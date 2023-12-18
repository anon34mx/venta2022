using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using System.Windows.Forms;
using Microsoft.Web.WebView2.Core;
using Microsoft.Web.WebView2.WinForms;
using System.Text.Json;
using System.Text.Json.Serialization;
using Newtonsoft.Json;
using System.Drawing.Printing;
using RawPrint;
using MySql.Data.MySqlClient;
using libc.hwid;
using static ventaParhikuniWin.Tools;
using static ventaParhikuniWin.Message;

namespace ventaParhikuniWin
{
    public partial class VentanaPrincipal : Form
    {
        string servidorweb = "172.17.1.138";
        string puertoWeb = ":8000";

        string db_server = "172.17.1.138";
        string db_user = "ventaWindows";
        string db_pass = "gONqkb9KCP4Y*QND";
        string db_name = "laravel";

        float versionMasReciente;

        enableDevTools devToolsForm;
        AcercaDe AboutForm;
        public VentanaPrincipal()
        {
            InitializeComponent();
            //Process.Start(AppDomain.CurrentDomain.BaseDirectory+@"\assets"); // Para abrir una carpeta
        }
        private async Task Initizated()
        {
            try
            {
                // validar navegador
                //var hardwareId = libc.hwid.HwId.Generate();

                // Validar versión de este cliente(navegador)
                string cs = @"server="+ db_server + @";userid="+ db_user + @";password='"+ db_pass + @"';database="+ db_name;
                MySqlConnection con = new MySqlConnection(cs);
                con.Open();
                var stm = @"SELECT version FROM `cliente_windows` WHERE liberado<=CURRENT_TIMESTAMP ORDER BY liberado DESC LIMIT 1";
                var cmd = new MySqlCommand(stm, con);
                MySqlDataReader rdr = cmd.ExecuteReader();
                // Console.WriteLine($"MySQL version: {version}");
                Console.Write("Version más actual");
                while (rdr.Read())
                {
                    versionMasReciente = rdr.GetFloat("version");
                    Console.WriteLine(versionMasReciente);
                }

            }catch (Exception ex)
            {

            }


            await webView21.EnsureCoreWebView2Async(null);

            // Quitamos el funcionamiento de arrastrar y soltar
            await webView21.CoreWebView2.AddScriptToExecuteOnDocumentCreatedAsync(
                "window.addEventListener('dragover',function(e){e.preventDefault();},false);" +
                "window.addEventListener('drop',function(e){" +
                    "e.preventDefault();" +
                    "console.log(e.dataTransfer);" +
                    "console.log(e.dataTransfer.files[0])" +
                "}, false);"
                
            );
            // + "window.addEventListener('contextmenu', window => {window.preventDefault();});" // deshabilitar menú contextual
            /*
                pantalla completa 
                descargas
                borrar cache
                titulo
             */
            webView21.CoreWebView2.NewWindowRequested += CoreWebView2_NewWindowRequested; // hacer que no se abran ventanas nuevas, si no en la misma
            webView21.CoreWebView2.WebMessageReceived += MessageReceived; // se establece la comunicación con Javscript
            webView21.CoreWebView2.Settings.AreDevToolsEnabled = false; // desabilitar herramientas de desarrollador
            webView21.CoreWebView2.Settings.IsBuiltInErrorPageEnabled = false; // se deshabilita la página de error por default
            webView21.CoreWebView2.Settings.IsPasswordAutosaveEnabled= false; // deshabilita el guardado de contraseñas
            // webView21.CoreWebView2.Settings.AreDefaultContextMenusEnabled = false; // se deshabilita el menú contextual
            webView21.CoreWebView2.Settings.HiddenPdfToolbarItems = CoreWebView2PdfToolbarItems.Save | CoreWebView2PdfToolbarItems.SaveAs | CoreWebView2PdfToolbarItems.Search | CoreWebView2PdfToolbarItems.Print | CoreWebView2PdfToolbarItems.Rotate | CoreWebView2PdfToolbarItems.MoreSettings; // | CoreWebView2PdfToolbarItems.Print

            webView21.CoreWebView2.ContextMenuRequested += delegate (object sender, CoreWebView2ContextMenuRequestedEventArgs args)
            {
                IList<CoreWebView2ContextMenuItem> menuList = args.MenuItems;
                CoreWebView2ContextMenuTargetKind context = args.ContextMenuTarget.Kind;
                if (context == CoreWebView2ContextMenuTargetKind.Page)
                {
                    for (int index = 0; index < menuList.Count; index++)
                    {
                        if (menuList[index].Name == "inspectElement" | menuList[index].Name == "saveAs" | menuList[index].Name == "saveLinkAs" | menuList[index].Name == "share")
                        {
                            menuList.RemoveAt(index);
                        }
                    }
                }
                if (context == CoreWebView2ContextMenuTargetKind.Audio)
                {
                    for (int index = 0; index < menuList.Count; index++)
                    {
                        //Console.WriteLine(menuList[index].Name);
                    }
                }
                if (context == CoreWebView2ContextMenuTargetKind.SelectedText)
                {
                    for (int index = 0; index < menuList.Count; index++)
                    {
                        if (menuList[index].Name == "copyLinkToHighlight")
                        {
                            menuList.RemoveAt(index);
                        }
                    }
                }
                if (context == CoreWebView2ContextMenuTargetKind.Image)
                {
                    for (int index = 0; index < menuList.Count; index++)
                    {
                        if (menuList[index].Name == "saveLinkAs" | menuList[index].Name == "copyLinkLocation" | menuList[index].Name == "saveImageAs" | menuList[index].Name == "copyImage"
                            | menuList[index].Name == "copyImageLocation" | menuList[index].Name == "openLinkInNewWindow" | menuList[index].Name == "share")
                        {
                            menuList.RemoveAt(index);
                        }
                    }
                }
                if (context == CoreWebView2ContextMenuTargetKind.Video)
                {
                    for (int index = 0; index < menuList.Count; index++)
                    {
                        if (menuList[index].Name == "saveMediaAs" | menuList[index].Name == "copyLink" | menuList[index].Name == "copyLinkLocation")
                        {
                            menuList.RemoveAt(index);
                        }
                    }
                }
            };
        }
        public async void InitBrowser()
        {
            await Initizated();
            //Cambiarpagina("/ventaInterna");
            Cambiarpagina("http://localhost/kuniticket/?origen=MORE&id_kiosko=1");
        }
        // Mis funciones c:
        private void CoreWebView2_NewWindowRequested(object sender, CoreWebView2NewWindowRequestedEventArgs e)
        {
            e.NewWindow = (CoreWebView2)sender;
            e.Handled = false;
        }
        private void Cambiarpagina(string pagina)
        {
            try
            {
                //webView21.CoreWebView2.Navigate("http://"+servidorweb + puertoWeb + pagina);
                webView21.CoreWebView2.Navigate(pagina);
            }
            catch (Exception)
            {
                //throw;
            }
        }
        // Mis funciones [FIN]
        private void VentanaPrincipal_Load_1(object sender, EventArgs e)
        {
            InitBrowser();
        }

        private async void webView21_NavigationCompleted(object sender, CoreWebView2NavigationCompletedEventArgs e)
        {
            //para que np se vea la dirección del servidor
            string urlActual = webView21.Source.ToString();
            barraDireccion.Text = urlActual.Replace("http://" + servidorweb + puertoWeb, "");

            if (webView21.Source.ToString() == "about:blank")
            {
                // evitamos que se quede repitiendo el ciclo
                webView21.CoreWebView2.Stop();
            }
            else
            {
                if (!e.IsSuccess)
                {
                    //Console.WriteLine("+++++++++++++++++++++++++");
                    //Console.WriteLine(e.IsSuccess);
                    //Console.WriteLine(e.HttpStatusCode);
                    //Console.WriteLine(e.WebErrorStatus); // este da el detalle del error chido
                    //Console.WriteLine(e.NavigationId);

                    string html=File.ReadAllText("./assets/404.html");
                    html=html.Replace("#ERRORCODE#", e.WebErrorStatus.ToString() );
                    webView21.CoreWebView2.NavigateToString(html);
                }else if (webView21.Source.ToString() == "http://" + servidorweb + puertoWeb + "/login")
                {
                    await webView21.ExecuteScriptAsync(@"var x=document.getElementsByTagName('form');
                            for (let i = 0; i < x.length; i++) {
                                var browserValidator=null;
                                var hwidValidator=null;
                                x[i].onsubmit = function () {
                                    if (x[i].querySelector('#browserValidator') == null){
                                        browserValidator=document.createElement('input');
                                        browserValidator.id = 'browserValidator';
                                        browserValidator.name = 'browserValidator';
                                        browserValidator.value = 'browserValidator';
                                        browserValidator.style.display = 'none';
                                        x[i].append(browserValidator);

                                        hwidValidator=document.createElement('input');
                                        hwidValidator.id = 'hwidValidator';
                                        hwidValidator.name = 'hwidValidator';
                                        hwidValidator.value = '" + CreateMD5(libc.hwid.HwId.Generate()) + @"';
                                        hwidValidator.style.display = 'none';
                                        x[i].append(hwidValidator);
                                    }
                                }
                            }");
                }
                else if (webView21.Source.ToString() != "http://" + servidorweb + puertoWeb + "/login" && webView21.Source.ToString() != "http://" + servidorweb + puertoWeb + "/register")
                {
                    Console.WriteLine("validar navegador aqui");
                }
            }

        }

        private void barraDireccion_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyData == Keys.Enter)
            {
                Cambiarpagina(barraDireccion.Text);
            }
        }

        private async void imprimirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            webView21.ExecuteScriptAsync(@"print()");
        }

        private void acercadeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (AboutForm == null || AboutForm.Text=="")
            {
                AboutForm = new AcercaDe(versionMasReciente);
                AboutForm.Visible = true;
            }
            else
            {
                AboutForm.Focus();
            }
        }



        private void button1_Click(object sender, EventArgs e)
        {
            LeerDatosTarjeta();
        }

        // Llamar desde JS en el navegador
        void MessageReceived(object sender, CoreWebView2WebMessageReceivedEventArgs args)
        {
            String content = args.TryGetWebMessageAsString();
            Message myDeserializedClass = null;


            try
            {
                myDeserializedClass = JsonConvert.DeserializeObject<Message>(content);
            }
            catch (Exception)
            {
                Console.WriteLine(content);
                throw;
            }

            switch (myDeserializedClass.Metodo)
            {
                case "leerTarjetaBancaria":
                    LeerDatosTarjeta();
                    break;
                case "imprimir":
                    // ImprimirBoletos("boleto.pdf");
                    break;
                case "descargarBoletos":
                    File.WriteAllBytes("boleto.pdf", Convert.FromBase64String(myDeserializedClass.Datos));
                    ImprimirBoletos("boleto.pdf");
                    break;
            }
        }
        private void LeerDatosTarjeta()
        {
            try
            {
                string[] lines = File.ReadAllLines("C:\\Lector\\tarjeta.txt");
                webView21.ExecuteScriptAsync("llenarTarjeta({tarjeta:'" + lines[0] + "', expiracion:'" + lines[1] + "', ccv:'" + lines[2] + "'})");
            }
            catch (IOException e)
            {
                Console.WriteLine(e);
            }
        }
        /*
            private void ImprimirDocumento(String archivo)
            {
                // Esta funcion imprime un documento PERO lo abre primero en el programa por DEFAULT
                Process p = new Process();
                p.StartInfo = new ProcessStartInfo()
                {
                    CreateNoWindow = false,
                    Verb = "print",
                    FileName = archivo //put the correct path here
                };
                Console.WriteLine("ImprimirDocumento()");
                p.Start();
            }
        
            private void ImprimirBoletos(string archivo){
                // FALLÓ
                PrintDocument pd = new PrintDocument();
                pd.PrinterSettings.PrinterName = Properties.Settings.Default["ImpresoraBoletos"].ToString();
                pd.Print();
            }
        */
        private void ImprimirBoletos(string archivo)
        {
            Console.WriteLine("Se manda a imprimir");
            string Filepath = @"C:\xampp\htdocs\venta2022\ventaParhikuniWin\bin\Debug\boleto.pdf";
            // The name of the PDF that will be printed (just to be shown in the print queue)
            string Filename = Filepath;
            // The name of the printer that you want to use
            // Note: Check step 1 from the B alternative to see how to list
            // the names of all the available printers with C#
            string PrinterName = Properties.Settings.Default["ImpresoraBoletos"].ToString();

            // Create an instance of the Printer
            IPrinter printer = new Printer();

            // Print the file
            printer.PrintRawFile(PrinterName, Filepath, Filename);
            Console.WriteLine(PrinterName);
            Console.WriteLine(Filepath);
            Console.WriteLine(Filename);
        }


        private void back_Click(object sender, EventArgs e)
        {
            webView21.CoreWebView2.GoBack();
        }

        private void fordward_Click(object sender, EventArgs e)
        {
            webView21.CoreWebView2.GoForward();
        }

        private void reload_Click(object sender, EventArgs e)
        {
            webView21.CoreWebView2.Reload();
        }

        private void home_Click(object sender, EventArgs e)
        {
            Cambiarpagina("/");
        }

        private void opcionesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // abrir configuracion
            Configuracion ConfigForm = new Configuracion();
            ConfigForm.Visible = true;
        }


        private void button1_Click_1(object sender, EventArgs e)
        {
            Console.WriteLine("Habilitar consola");
            webView21.CoreWebView2.Settings.AreDevToolsEnabled = true;
            webView21.CoreWebView2.Reload();
        }

        private void devToolsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (devToolsForm == null || devToolsForm.Text == "")
            {
                devToolsForm = new enableDevTools(webView21);
                devToolsForm.Visible = true;
            }
            else
            {
                devToolsForm.Focus();
            }
        }

        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private async void capturaDePantallaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Using ms As New IO.MemoryStream();
            Directory.CreateDirectory(Environment.GetFolderPath(Environment.SpecialFolder.MyPictures)+@"\venta parhikuni\" );

            MemoryStream ms = new MemoryStream();
            FileStream file =new FileStream(Environment.GetFolderPath(Environment.SpecialFolder.MyPictures) + @"\venta parhikuni\"+ DateTime.Now.ToString("yyyy -MM-dd HH.mm.ss") + ".png", FileMode.Create);
            await webView21.CoreWebView2.CapturePreviewAsync(CoreWebView2CapturePreviewImageFormat.Png, ms);

            ms.Seek(0, SeekOrigin.Begin);
            ms.CopyTo(file);
            Console.WriteLine(DateTime.Now.ToString("yyyy-MM-dd HH.mm.ss")); ;
            // Console.WriteLine(Environment.GetFolderPath(Environment.SpecialFolder.MyPictures)+@"\ventaParhikuni\captura de pantalla.png");
        }
    }
}

