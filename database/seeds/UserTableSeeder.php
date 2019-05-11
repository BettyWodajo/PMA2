<?php

use Illuminate\Database\Seeder;
use Faker\Factory as Faker;
use Carbon\Carbon;
use App\User;

class UserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();
        User::create([
            'full_name' => $faker->name,
             'email' => $faker->unique()->safeEmail,
             'password' => bcrypt('password'),
             'active' => 1,
             'role' => 'admin',
             'address' => $faker->address,
             'created_at' => Carbon::now(),
             'updated_at' => Carbon::now()
         ]);
    }
}
