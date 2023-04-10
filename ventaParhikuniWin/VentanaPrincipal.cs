using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
        }
        public async void InitBrowser()
        {
            await Initizated();
            Cambiarpagina("/");
        }
        // Mis funciones c:
        private void Cambiarpagina(string pagina)
        {
            webView21.CoreWebView2.Navigate("http://localhost:8000"+pagina);
        }
        // Mis funciones [FIN]
        private void VentanaPrincipal_Load_1(object sender, EventArgs e)
        {
            InitBrowser();
        }

        private void webView21_NavigationCompleted(object sender, CoreWebView2NavigationCompletedEventArgs e)
        {
            string urlActual=webView21.Source.ToString();
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
        }

        private void barraDireccion_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyData == Keys.Enter)
            {
                Cambiarpagina(barraDireccion.Text);
            }
        }

        private void imprimirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            webView21.ExecuteScriptAsync(@"print()");
        }

        private void acercadeToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }
    }
}
