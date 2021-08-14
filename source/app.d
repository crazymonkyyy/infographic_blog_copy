import raylib;
import std.string;
import std.process;
import colors;
struct button{
	int x;int y;
	int w; int h;
	int strange;
	string s;
	int color;
	void draw(){
		if(strange>0){
			
		}else{
			DrawRectangle(x,y,w,h,mycolors[color]);
			DrawText(s.toStringz,x+5,y+5,16,mycolors[0]);
	}}
}
string exe(string input){//"make the annoying gtk warnings in zenity go away, mmmk?" the function
	auto config=Config.stderrPassThrough;
	return input.executeShell(null,config).output[0..$-1];
}
void main(string[] commandlineinput){
	InitWindow(800, 600, "Hello, Raylib-D!");
	SetWindowPosition(2000,0);
	

	auto mybutton=button(100,100,100,100,0,"A",8);
	string hello;
	import settingv2; import std.stdio;
	mixin setup!"config";
	reload!"config";
	
	button grid;//it has a w and h already defined
	button tool;
	mixin setup!"tool";
	reload!"tool";
	tool.s="!";
	
	button[] buttons;
	mixin setup!"data";
	reload!"data"(commandlineinput[1]);
	void savedata(){
		save!"data"(commandlineinput[1]);
	}
	SetTargetFPS(60);
	while (!WindowShouldClose()){with(KeyboardKey){
		BeginDrawing();
		ClearBackground(mycolors[0]);
			if(IsKeyPressed(KEY_SPACE)){
				reload!"tool";
			}
			button temp=tool;
			temp.x=(GetMouseX/grid.w)*grid.w+grid.x;
			temp.y=(GetMouseY/grid.h)*grid.h+grid.y;
			temp.draw;
			if(IsKeyPressed(KEY_F1)){
				hello="zenity --entry".exe;
				save!"config";
			}
			if(IsKeyPressed(KEY_F5)){ savedata;}
			if(IsMouseButtonPressed(0)){buttons~=temp;}
			foreach(e;buttons){e.draw;}
			mybutton.draw;
			DrawText(hello.toStringz, 100, 0, 28, BLACK);
			DrawFPS(10,10);
		EndDrawing();
	}}
	CloseWindow();
}
