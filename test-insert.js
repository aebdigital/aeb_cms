import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://ngifengeshwvyzhqvprn.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5naWZlbmdlc2h3dnl6aHF2cHJuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ5Mjk0NzcsImV4cCI6MjA4MDUwNTQ3N30.VgFpOYFfnqQWrWke5U0HAt1OkYHQHiIzkk2MRBYGD8c';

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function run() {
  console.log('Testing course application insert with frontend keys...');
  const { data: res1, error: err1 } = await supabase
    .from('viktorija_course_applications')
    .insert({
      course_name: 'The Art of PMU',
      client_name: 'Test Student',
      client_email: 'test@example.com',
      client_phone: '123456789',
      selected_term: 'Test Term',
    })
    .select();
  console.log('Res 1:', res1, 'Error 1:', err1);

  console.log('Testing contact messages insert with client_name...');
  const { data: res2, error: err2 } = await supabase
    .from('viktorija_contact_messages')
    .insert({
      client_name: 'Test Contact',
      client_phone: '123456789',
      message: 'Test Message',
    })
    .select();
  console.log('Res 2:', res2, 'Error 2:', err2);
}

run();
