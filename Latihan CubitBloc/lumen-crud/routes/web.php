<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});
$router->get('/api/posts', 'PostController@index');
$router->post('/api/newposts', 'PostController@store');
$router->get('/api/posts/{id}', 'PostController@show');
$router->put('/api/posts/update/{id}', 'PostController@update');
$router->delete('/api/posts/delete/{id}', 'PostController@destroy');
