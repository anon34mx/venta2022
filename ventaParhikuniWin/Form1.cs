using Microsoft.Web.WebView2.Core;
using Microsoft.Web.WebView2.WinForms;

namespace ventaParhikuniWin
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private async Task initizated()
        {
            await webView21.EnsureCoreWebView2Async(null);

        }
        public async void InitBrowser()
        {
            await initizated();
            webView21.CoreWebView2.Navigate("http://localhost:8000/browser");
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            InitBrowser();
        }
    }
}