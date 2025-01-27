// client.js  CLIENT SIDE LOGIC
import { createClient } from "@supabase/supabase-js";
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

const authenticateUser  = async (email, password) => {
  try {
    const { data, error } = await supabase
      .auth
      .signInWithPassword({ email, password });

    if (error) {
      console.error(error);
      return null;
    }

    return data;
  } catch (error) {
    console.error(error);
    return null;
  }
};

// Example usage:
const email = "user@example.com";
const password = "password";
const userData = await authenticateUser (email, password);
console.log(userData);


const getData = async (user) => {
    try {
      const token = user.session.access_token;
      const headers = {
        'Authorization': `Bearer ${token}`,
      };
      const response = await fetch('http://localhost:3000/data', { headers });
      const data = await response.json();
      console.log(data);
    } catch (error) {
      console.error(error);
    }
  };
  
if (userData){
    getData(userData);
}
