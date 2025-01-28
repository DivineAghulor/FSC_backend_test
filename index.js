// index.js SERVER SIDE LOGIC
import express from 'express';
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

const app = express();
app.use(express.json());

const fetchRows = async () => {
  try {
    const { data, error } = await supabase
      .from('testing')
      .select();

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

app.get('/data', async (req, res) => {
    const authHeader = req.headers['authorization'];
    if (!authHeader) {
      return res.status(401).json({ error: 'Unauthorized' });
    }
  
    const token = authHeader.split(' ')[1];
    const { data, error } = await supabase.auth.getUser(token);
    if (error || !data) {
      return res.status(401).json({ error: 'Unauthorized' });
    }
   
    const user = data.user;
    const rows = await fetchRows(user);
    res.json(rows);
  });


const PORT = process.env.PORT || 3000;

app.listen(PORT, ()=>{
    console.log(`Listening on port ${PORT}`);

  })


//CREATE ALL THE MAJOR ENDPOINTS
// THE CORE OF THE FULLSTACK CREATORS APP
// I can make an order
// The order gets broadcasted (idk if this is my issue yet)
// I (creator) can make a bid
// I can accept the bid

