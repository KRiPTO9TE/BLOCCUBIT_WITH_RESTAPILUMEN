<?php

namespace App\Http\Controllers;

//model post
use App\Models\Post;
use Illuminate\Http\Request;

class PostController extends Controller
{
    public function index()
    {
        return response()->json([
            
            'status' => 'success',
            'message' => 'Load data post successfully',
            'data' => Post::all()
        ], 200);
    }
    public function store(Request $request)
    {
        $message = 'Post created successfully';
        $status = "success";
        try {
            Post::create([
                'title' => $request->title,
                'content' => $request->content,
            ]);
        } catch (\Throwable $th) {
            $status = "error";
            $message = $th->getMessage();
        }

        return response([
            'status' => $status,
            'message' => $message,
        ], 200);
    }
    public function show($id)
    {
        $message = "Load data post successfully";
        $status = "success";
        $post = Post::find($id);

        if (!$post) {
            $status = "error";
            $message = "Data post not found";
        }

        return response()->json([
            'status' => $status,
            'message' => $message,
            'data' => $post
        ], 200);
    }
    public function update(Request $request, $id)
    {
        $message = 'Post updated successfully';
        $status = "success";
        try {
            Post::find($id)->update([
                'title' => $request->title,
                'content' => $request->content,
            ]);
        } catch (\Throwable $th) {
            $status = "error";
            $message = $th->getMessage();
        }

        return response()->json([
            'status' => $status,
            'message' => $message,
        ], 200);
    }
    public function destroy($id)
    {
        $message = 'Post deleted successfully';
        $status = "success";
        try {
            Post::find($id)->delete();
        } catch (\Throwable $th) {
            $status = "error";
            $message = $th->getMessage();
        }

        return response()->json([
            'status' => $status,
            'message' => $message,
        ], 200);
    }
}