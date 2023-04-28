using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ventaParhikuniWin
{
    public static class Tools
    {
        public static string CreateMD5(string input)
        {
            // Use input string to calculate MD5 hash
            using (System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create())
            {
                byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);

                // return Convert.ToHexString(hashBytes); // .NET 5 +

                // Convert the byte array to hexadecimal string prior to .NET 5
                return ByteArrayToString(hashBytes);
            }
        }

        public static string ByteArrayToString(byte[] hashBytes)
        {
            StringBuilder sb = new System.Text.StringBuilder();
            for (int i = 0; i < hashBytes.Length; i++)
            {
                sb.Append(hashBytes[i].ToString("X2"));
            }
            return sb.ToString();
        }

        public static byte[] StringToCharArray(string sentence)
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
}
