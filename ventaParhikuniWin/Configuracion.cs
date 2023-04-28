using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Drawing.Printing;
using ventaParhikuniWin.Properties;
using libc.hwid;
using static ventaParhikuniWin.Tools;

namespace ventaParhikuniWin
{
    public partial class Configuracion : Form
    {
        public Configuracion()
        {
            InitializeComponent();

            foreach (string s in PrinterSettings.InstalledPrinters)
            {
                comboImpresoras.Items.Add(s);
                //Console.WriteLine( Properties.Settings.Default["ImpresoraBoletos"] ); //ImpresoraBoletos
            }
            comboImpresoras.SelectedIndex = comboImpresoras.FindStringExact(Properties.Settings.Default["ImpresoraBoletos"].ToString());
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Properties.Settings.Default.ImpresoraBoletos = comboImpresoras.Items[comboImpresoras.SelectedIndex].ToString();
            Properties.Settings.Default.Save(); // Saves settings in application configuration file
            this.Close();
            MessageBox.Show("Guardado");
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            var hardwareId = CreateMD5(libc.hwid.HwId.Generate());

            Console.WriteLine(hardwareId);
            hwidbox.Text=hardwareId;
        }
    }
}
