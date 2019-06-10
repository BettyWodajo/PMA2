<?php

namespace App\Http\Controllers;

use App\Message;
use Illuminate\Http\Request;
use App\Events\newMessage;

class MessageController extends Controller
{
    public function messages($id) {
        $messages = Message::where(function($q) use($id) {
            $q->where('to', $id)->orderBy('created_at', 'desc')->get();
        })->with('sender')->orderBy('created_at', 'desc')->get()->unique('from');

        $tempMessages = [];

        foreach ($messages as $key => $value) {
            array_push($tempMessages, $value);
        }

        return response($tempMessages);
    }

    public function getConversation($from, $to)
    {
        $messages = Message::where(function($q) use($from, $to) {
            $q->where('from', $from);
            $q->where('to', $to);
        })->orWhere(function($q) use($from, $to) {
            $q->where('from', $to);
            $q->where('to', $from);
        })->get();

        return response()->json($messages);
    }

    public function send(Request $request)
    {
        $message = Message::create([
            'from' => $request->from,
            'to' => $request->to,
            'text' => $request->text
        ]);

        broadcast(new newMessage($message));
        return response()->json($message);
    }
}
