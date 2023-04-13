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
            Cambiarpagina("/");
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
                webView21.ExecuteScriptAsync(@"var x=document.getElementsByTagName('form');
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
            // Console.WriteLine(args.WebMessageAsJson);
            //JavaScriptSerializer js = new JavaScriptSerializer();
            //string jsonData = js.Serialize(args.WebMessageAsJson);
            //Console.WriteLine(jsonData);
            

            if (content.StartsWith("leerTarjetaBancaria"))
            {
                LeerDatosTarjeta();
            }

            switch (content)
            {
                case "imprimir":
                    imprimirDocumento();
                    break;
            }
        }
        private void LeerDatosTarjeta()
        {
            try
            {
                Console.WriteLine("Aquí debe comunicarse con JS");
                string[] lines = File.ReadAllLines("C:\\Lector\\tarjeta.txt");
                // Console.WriteLine(lines[0]);

                webView21.ExecuteScriptAsync("llenarTarjeta({tarjeta:'" + lines[0] + "', expiracion:'" + lines[1] + "', ccv:'" + lines[2] + "'})");
            }
            catch (IOException e)
            {

            }
        }

        private void imprimirDocumento()
        {

        }
    }
}
