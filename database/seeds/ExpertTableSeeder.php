<?php

use Illuminate\Database\Seeder;
use Faker\Factory as Faker;
use Carbon\Carbon;
use App\User;
use App\Expert;

class ExpertTableSeeder extends Seeder
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
             'role' => 'expert',
             'address' => $faker->address,
             'created_at' => Carbon::now(),
             'updated_at' => Carbon::now()
         ]);

         Expert::create([
            'job_location' => $faker->address,
            'specialization_area' => $faker->text,
            'user_id' => $user->id
         ]);
    }
}
