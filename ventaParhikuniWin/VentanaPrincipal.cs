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

namespace ventaParhikuniWin
{
    public partial class VentanaPrincipal : Form
    {
        public VentanaPrincipal()
        {
            InitializeComponent();
        }
        private async Task Initizated()
        {
            await webView21.EnsureCoreWebView2Async(null);
            // Quitamos el funcionamiento de arrastrar y soltar
            await webView21.CoreWebView2.AddScriptToExecuteOnDocumentCreatedAsync(
                "window.addEventListener('dragover',function(e){e.preventDefault();},false);" +
                "window.addEventListener('drop',function(e){" +
                    "e.preventDefault();" +
                    "console.log(e.dataTransfer);" +
                    "console.log(e.dataTransfer.files[0])" +
                "}, false);" +
                "window.addEventListener('contextmenu', window => {window.preventDefault();});"
            );
            webView21.CoreWebView2.WebMessageReceived += MessageReceived;
            // webView21.CoreWebView2.Settings.IsBuiltInErrorPageEnabled = false;
            //Quitamos el menu contextual (click derecho)
            // await webView21.CoreWebView2.ExecuteScriptAsync("");
        }
        public async void InitBrowser()
        {
            await Initizated();
            Cambiarpagina("/ventaInterna/9/boletos/preview/TAQ");
        }
        // Mis funciones c:
        private void Cambiarpagina(string pagina)
        {
            webView21.CoreWebView2.Navigate("http://localhost:8000" + pagina);
        }
        // Mis funciones [FIN]
        private void VentanaPrincipal_Load_1(object sender, EventArgs e)
        {
            InitBrowser();
        }

        private async void webView21_NavigationCompleted(object sender, CoreWebView2NavigationCompletedEventArgs e)
        {
            string urlActual = webView21.Source.ToString();
            barraDireccion.Text = urlActual.Replace("http://localhost:8000", "");
            if (webView21.Source.ToString() == "http://localhost:8000/login")
            {
                await webView21.ExecuteScriptAsync(@"var x=document.getElementsByTagName('form');
                    for (let i = 0; i < x.length; i++) {
                        var newInput=null;
                        x[i].onsubmit = function () {
                            if (x[i].querySelector('#browserValidator') == null){
                                newInput=document.createElement('input');
                                newInput.id = 'browserValidator';
                                newInput.name = 'browserValidator';
                                newInput.value = 'browserValidator';
                                newInput.style.display = 'none';
                                x[i].append(newInput);
                            }
                        }
                    }");
            }

            if (!e.IsSuccess)
            {
                Console.WriteLine(e.WebErrorStatus);
                //webView21.CoreWebView2.Navigate("<Hubo un error :c>");
                if (e.WebErrorStatus.ToString() == "HostNameNotResolved")
                {
                    var html = @"
                        <html>
                            <head><title>ERROR</title></head>
                            <body>
                                Hubo un error :c
                            </body>
                        </html>";

                    await webView21.EnsureCoreWebView2Async();
                    webView21.NavigateToString(html);
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
            AcercaDe AboutForm = new AcercaDe();
            AboutForm.Visible = true;
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
                    /*
                        //byte[] pdfBytes = Convert.FromBase64String(myDeserializedClass.Datos);
                        //string pdfString = System.Text.Encoding.UTF8.GetString(pdfBytes).Replace("\n", "\r\n");
                        //File.WriteAllBytes("boleto.pdf", System.Text.Encoding.UTF8.GetBytes(pdfString));
                        //ImprimirBoletos("boleto.pdf");
                    */
                    /*
                     * SIRVE
                        //File.WriteAllBytes("boleto.pdf", Convert.FromBase64String(myDeserializedClass.Datos)); //Convert.FromBase64String(myDeserializedClass.Datos)
                        //ImprimirBoletos("boleto.pdf");
                     */
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
            webView21.GoBack();
        }

        private void fordward_Click(object sender, EventArgs e)
        {
            webView21.GoForward();
        }

        private void reload_Click(object sender, EventArgs e)
        {
            webView21.Refresh();
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
        public byte[] StringToCharArray(string sentence)
        {
            char[] charArr = sentence.ToCharArray();
            byte[] byteArr = new byte[charArr.Length];
            for (int i = 0; i < charArr.Length; i++)
            {
                byteArr[i] = Convert.ToByte(charArr[i]);
            }

            return byteArr;
        }
    }
    // Message myDeserializedClass = JsonConvert.DeserializeObject<Message>(myJsonResponse);
    public class Message
    {
        public string Metodo { get; set; }
        public string Datos { get; set; }
    }
}

