<?php

use Illuminate\Database\Seeder;
use Faker\Factory as Faker;
use Carbon\Carbon;
use App\Disease;

class DiseaseTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();

        $description = [];
        for($i = 0; $i < 5; $i++) {
            array_push($description, [
                'name' => $faker->sentence
            ]);
        };

        Disease::create([
            'name' => $faker->firstNameMale,
             'symptom' => $faker->text,
             'description' => json_encode($description),
             'created_at' => Carbon::now(),
             'updated_at' => Carbon::now()
         ]);
    }
}
