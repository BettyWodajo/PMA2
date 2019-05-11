<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <!-- CSRF Token -->
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <meta charset="utf-8">
        @guest()
            <meta name="user" content="null">
        @else
            <meta name="user" content="{{ Auth::user() }}">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        @endguest
        <title>Laravel</title>
        <style>
            html {
                font-family: 'Roboto', sans-serif;
            }
            a {
                text-decoration: none !important;
            }
        </style>

        <!-- Fonts -->
        {{--<link href="https://fonts.googleapis.com/css?family=Nunito:200,600" rel="stylesheet" type="text/css">--}}
{{--        <link href="{{ (asset('css/app.css'))  }}" rel="stylesheet">--}}
        <link href='https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons' rel="stylesheet">
    </head>
    <body>
    <div id="app">
        <main-app/>
    </div>
    <script src="{{ asset('js/app.js') }}"></script>
    </body>
</html>
