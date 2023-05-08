using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ventaParhikuniWin
{
    public partial class AcercaDe : Form
    {
        public AcercaDe(float versionMasReciente)
        {
            InitializeComponent();
            lblVersion.Text = "Version:" + Properties.Settings.Default["version"].ToString();
            Console.WriteLine(versionMasReciente);
            if (versionMasReciente > float.Parse(Properties.Settings.Default["version"].ToString()))
            {
                linkUpdate.Visible = true;
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}
