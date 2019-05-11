<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call(UserTableSeeder::class);
        $this->call(DiseaseTableSeeder::class);
        $this->call(BlogTableSeeder::class);
        $this->call(ExpertTableSeeder::class);
        $this->call(CustomerTableSeeder::class);
        $this->call(FirstAidTableSeeder::class);
    }
}
