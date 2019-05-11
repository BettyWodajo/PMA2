<?php

use Illuminate\Database\Seeder;
use Faker\Factory as Faker;
use Carbon\Carbon;
use App\Blog;

class BlogTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();
        Blog::create([
            'header' => $faker->sentence($nbWords = 6, $variableNbWords = true),
             'content' => $faker->paragraph,
             'img' => 'img.jpg',
             'user_id' => 1,
             'created_at' => Carbon::now(),
             'updated_at' => Carbon::now()
         ]);
    }
}
