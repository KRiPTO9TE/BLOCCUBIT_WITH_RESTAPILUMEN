<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PostTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('posts')->insert([
            [
                'title' => "Lumen CRUD",
                'content' => "CRUD adalah kependekan dari Create Read Update dan DELETE"
            ],
            [
                'title' => "Apa itu Pemrograman PHP?",
                'content' => "Hypertext Preprocessor adalah bahasa skrip yang dapat ditanamkan atau disisipkan ke dalam HTML."
            ],
            [
                'title' => "Apa itu HTML?",
                'content' => "Hypertext Markup Language adalah bahasa markah standar untuk dokumen yang dirancang untuk ditampilkan di peramban internet."
            ],
        ]);
    }
}