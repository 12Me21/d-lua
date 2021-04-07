import luah;
import std.string : toStringz;

class Lua {
	lua_State* L;
	this() {
		L = luaL_newstate();
		
	}
	void openlibs() {
		luaL_openlibs(L);
	}
	int dostring(char* str) {
		return luaL_dostring(L, str);
	}
}

void main() {
	Lua x = new Lua();
	x.openlibs();
	x.dostring(cast(char*)"print('test')");
}
