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
using static ventaParhikuniWin.Tools;

namespace ventaParhikuniWin
{
    public partial class enableDevTools : Form
    {
        WebView2 webView21;
        public enableDevTools(WebView2 webview)
        {
            InitializeComponent();
            webView21 = webview;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            labelError.Text = "";
            webView21.CoreWebView2.Settings.AreDevToolsEnabled = true;
            webView21.CoreWebView2.Reload();
            Console.WriteLine(CreateMD5(password.Text));
            if (CreateMD5(password.Text) == "14934A812F0C9BA5EF9539B182341E50")
            {
                Console.WriteLine("Habilitar consola");
                labelError.Text = "";
                webView21.CoreWebView2.Settings.AreDevToolsEnabled = true;
                webView21.CoreWebView2.Reload();
                webView21.CoreWebView2.OpenDevToolsWindow();
                this.Close();
            }
            else
            {
                labelError.Text = "Contraseña inválida";
            }
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
    }
}
