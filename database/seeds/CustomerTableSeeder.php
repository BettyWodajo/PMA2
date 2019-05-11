<?php

use Illuminate\Database\Seeder;
use Faker\Factory as Faker;
use Carbon\Carbon;
use App\user;
use App\Customer;

class CustomerTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();
        $user = User::create([
            'full_name' => $faker->name,
             'email' => $faker->unique()->safeEmail,
             'password' => bcrypt('password'),
             'active' => 1,
             'role' => 'customer',
             'address' => $faker->address,
             'created_at' => Carbon::now(),
             'updated_at' => Carbon::now()
         ]);

         Customer::create([
            'disease_id' => 1,
            'user_id' => $user->id
         ]);
    }
}
