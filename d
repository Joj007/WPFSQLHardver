using MySql.Data.MySqlClient;
using System;

namespace MyApp // Note: actual namespace depends on the project name.
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Kategória: ");
            string kategoria = Console.ReadLine();
            MySqlConnection adatbaziskapcsolat = new("Server=127.0.0.1; Port=3306; Database=test; User=root; Password=;");
            adatbaziskapcsolat.Open();
            string SQLSelect = $"SELECT gyártó, COUNT(*) as darab, MAX(ár) as MAX, AVG(ár) as Átlag FROM termekek WHERE kategória = {kategoria} GROUP BY Gyártó";
            MySqlCommand SQLparancs = new(SQLSelect, adatbaziskapcsolat);
            MySqlDataReader eredmenyolvaso = SQLparancs.ExecuteReader();

            while (eredmenyolvaso.Read())
            {
                Console.Write(eredmenyolvaso.GetString("Gyártó").PadRight(30,'.'));
                Console.Write(eredmenyolvaso.GetString("Darab").PadLeft(30, '_') + " db");
                Console.Write(eredmenyolvaso.GetString("Átlag").PadLeft(20, ' ') + " Ft");
                string atlagar = $"{eredmenyolvaso.GetDouble("Átlag"):f1}";
                Console.Write(atlagar.PadLeft(15)+"Ft");
            }
            eredmenyolvaso.Close();
            adatbaziskapcsolat.Close();
        }
    }
}
