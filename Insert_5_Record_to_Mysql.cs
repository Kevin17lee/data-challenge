using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace Insert
{
    class InsertDate
    {
        static void Main(string[] args)
        {
            try
            {       //Establish Connection
                string MyConnection2 = "datasource=localhost;port=3306;username=root;password=Seeing8391";
                    //This is my insert query which can be modified to any source table 
                string Query = "insert into dermstore.customers(store_id,customer_firstname,customer_lastname,customer_email) values(@store_id,@customer_firstname,@customer_lastname,@customer_email);";
                using (MySqlConnection MyConn2 = new MySqlConnection(MyConnection2))
                {
                    MyConn2.Open();
                    for (int i = 0; i < 5; i++) //inserting 5 random items
                        using (MySqlCommand myCmd = new MySqlCommand(Query, MyConn2))
                        {
                            myCmd.CommandType = System.Data.CommandType.Text;
                            myCmd.Parameters.AddWithValue("@store_id", 64789+i);
                            myCmd.Parameters.AddWithValue("@customer_firstname", "test");
                            myCmd.Parameters.AddWithValue("@customer_lastname", "test");
                            myCmd.Parameters.AddWithValue("@customer_email", "test@gmail.com");
                            myCmd.ExecuteNonQuery();
                        }
                    MyConn2.Close();
                }                   
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
