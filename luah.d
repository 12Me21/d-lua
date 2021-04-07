/*
** $Id: lua.h,v 1.218.1.7 2012/01/13 20:36:20 roberto Exp $
** Lua - An Extensible Extension Language
** Lua.org, PUC-Rio, Brazil (http://www.lua.org)
** See Copyright Notice at the end of this file
*/

import core.stdc.config;
import core.stdc.limits;
import core.stdc.stddef;
import core.stdc.stdio;
import core.vararg;

extern (C):

/*
** $Id: luaconf.h,v 1.82.1.7 2008/02/11 16:25:08 roberto Exp $
** Configuration file for Lua
** See Copyright Notice in lua.h
*/

/*
** ==================================================================
** Search for "@@" to find all configurable definitions.
** ===================================================================
*/

/*
@@ LUA_ANSI controls the use of non-ansi features.
** CHANGE it (define it) if you want Lua to avoid the use of any
** non-ansi feature or library.
*/

/* needs an extra library: -ldl */
/* needs some extra libraries */

/* does not need extra library */

/*
@@ LUA_USE_POSIX includes all functionallity listed as X/Open System
@* Interfaces Extension (XSI).
** CHANGE it (define it) if your system is XSI compatible.
*/

/*
@@ LUA_PATH and LUA_CPATH are the names of the environment variables that
@* Lua check to set its paths.
@@ LUA_INIT is the name of the environment variable that Lua
@* checks for initialization code.
** CHANGE them if you want different names.
*/
enum LUA_PATH = "LUA_PATH";
enum LUA_CPATH = "LUA_CPATH";
enum LUA_INIT = "LUA_INIT";

/*
@@ LUA_PATH_DEFAULT is the default path that Lua uses to look for
@* Lua libraries.
@@ LUA_CPATH_DEFAULT is the default path that Lua uses to look for
@* C libraries.
** CHANGE them if your machine has a non-conventional directory
** hierarchy or if you want to install your libraries in
** non-conventional directories.
*/

/*
** In Windows, any exclamation mark ('!') in the path is replaced by the
** path of the directory of the executable file of the current process.
*/

/* This defines DEB_HOST_MULTIARCH */

enum LUA_ROOT = "/usr/local/";
enum LUA_ROOT2 = "/usr/";

/*
@@ LUA_DIRSEP is the directory separator (for submodules).
** CHANGE it if your machine does not use "/" as the directory separator
** and is not Windows. (On Windows Lua automatically uses "\".)
*/

enum LUA_DIRSEP = "/";

/*
@@ LUA_PATHSEP is the character that separates templates in a path.
@@ LUA_PATH_MARK is the string that marks the substitution points in a
@* template.
@@ LUA_EXECDIR in a Windows path is replaced by the executable's
@* directory.
@@ LUA_IGMARK is a mark to ignore all before it when bulding the
@* luaopen_ function name.
** CHANGE them if for some reason your system cannot use those
** characters. (E.g., if one of those characters is a common character
** in file/directory names.) Probably you do not need to change them.
*/
enum LUA_PATHSEP = ";";
enum LUA_PATH_MARK = "?";
enum LUA_EXECDIR = "!";
enum LUA_IGMARK = "-";

/*
@@ LUA_INTEGER is the integral type used by lua_pushinteger/lua_tointeger.
** CHANGE that if ptrdiff_t is not adequate on your machine. (On most
** machines, ptrdiff_t gives a good choice between int or long.)
*/
alias LUA_INTEGER = ptrdiff_t;

/*
@@ LUA_API is a mark for all core API functions.
@@ LUALIB_API is a mark for all standard library functions.
** CHANGE them if you need to define those functions in some special way.
** For instance, if you want to create one Windows DLL with the core and
** the libraries, you may want to use the following definition (define
** LUA_BUILD_AS_DLL to get it).
*/

/* more often than not the libs go together with the core */
//enum LUALIB_API = LUA_API;

/*
@@ LUAI_FUNC is a mark for all extern functions that are not to be
@* exported to outside modules.
@@ LUAI_DATA is a mark for all extern (const) variables that are not to
@* be exported to outside modules.
** CHANGE them if you need to mark them in some special way. Elf/gcc
** (versions 3.2 and later) mark them as "hidden" to optimize access
** when Lua is compiled as a shared library.
*/

/* empty */

//enum LUAI_DATA = LUAI_FUNC;

/*
@@ LUA_QL describes how error messages quote program elements.
** CHANGE it if you want a different appearance.
*/
//enum LUA_QS = LUA_QL("%s");

/*
@@ LUA_IDSIZE gives the maximum size for the description of the source
@* of a function in debug information.
** CHANGE it if you want a different size.
*/
enum LUA_IDSIZE = 60;

/*
** {==================================================================
** Stand-alone configuration
** ===================================================================
*/

/*
@@ lua_stdin_is_tty detects whether the standard input is a 'tty' (that
@* is, whether we're running lua interactively).
** CHANGE it if you have a better definition for non-POSIX/non-Windows
** systems.
*/

/* assume stdin is a tty */

/*
@@ LUA_PROMPT is the default prompt used by stand-alone Lua.
@@ LUA_PROMPT2 is the default continuation prompt used by stand-alone Lua.
** CHANGE them if you want different prompts. (You can also change the
** prompts dynamically, assigning to globals _PROMPT/_PROMPT2.)
*/

/*
@@ LUA_PROGNAME is the default name for the stand-alone Lua program.
** CHANGE it if your stand-alone interpreter has a different name and
** your system is not able to detect that name automatically.
*/

/*
@@ LUA_MAXINPUT is the maximum length for an input line in the
@* stand-alone interpreter.
** CHANGE it if you need longer lines.
*/

/*
@@ lua_readline defines how to show a prompt and then read a line from
@* the standard input.
@@ lua_saveline defines how to "save" a read line in a "history".
@@ lua_freeline defines how to free a line read by lua_readline.
** CHANGE them if you want to improve this functionality (e.g., by using
** GNU readline and history facilities).
*/

/* non-empty line? */
/* add it to history */

/* show prompt */
/* get line */

/* }================================================================== */

/*
@@ LUAI_GCPAUSE defines the default pause between garbage-collector cycles
@* as a percentage.
** CHANGE it if you want the GC to run faster or slower (higher values
** mean larger pauses which mean slower collection.) You can also change
** this value dynamically.
*/
enum LUAI_GCPAUSE = 200; /* 200% (wait memory to double before next GC) */

/*
@@ LUAI_GCMUL defines the default speed of garbage collection relative to
@* memory allocation as a percentage.
** CHANGE it if you want to change the granularity of the garbage
** collection. (Higher values mean coarser collections. 0 represents
** infinity, where each step performs a full collection.) You can also
** change this value dynamically.
*/
enum LUAI_GCMUL = 200; /* GC runs 'twice the speed' of memory allocation */

/*
@@ LUA_COMPAT_GETN controls compatibility with old getn behavior.
** CHANGE it (define it) if you want exact compatibility with the
** behavior of setn/getn in Lua 5.0.
*/

/*
@@ LUA_COMPAT_LOADLIB controls compatibility about global loadlib.
** CHANGE it to undefined as soon as you do not need a global 'loadlib'
** function (the function is still available as 'package.loadlib').
*/

/*
@@ LUA_COMPAT_VARARG controls compatibility with old vararg feature.
** CHANGE it to undefined as soon as your programs use only '...' to
** access vararg parameters (instead of the old 'arg' table).
*/

/*
@@ LUA_COMPAT_MOD controls compatibility with old math.mod function.
** CHANGE it to undefined as soon as your programs use 'math.fmod' or
** the new '%' operator instead of 'math.mod'.
*/

/*
@@ LUA_COMPAT_LSTR controls compatibility with old long string nesting
@* facility.
** CHANGE it to 2 if you want the old behaviour, or undefine it to turn
** off the advisory error when nesting [[...]].
*/
enum LUA_COMPAT_LSTR = 1;

/*
@@ LUA_COMPAT_GFIND controls compatibility with old 'string.gfind' name.
** CHANGE it to undefined as soon as you rename 'string.gfind' to
** 'string.gmatch'.
*/

/*
@@ LUA_COMPAT_OPENLIB controls compatibility with old 'luaL_openlib'
@* behavior.
** CHANGE it to undefined as soon as you replace to 'luaL_register'
** your uses of 'luaL_openlib'
*/

/*
@@ luai_apicheck is the assert macro used by the Lua-C API.
** CHANGE luai_apicheck if you want Lua to perform some checks in the
** parameters it gets from API calls. This may slow down the interpreter
** a bit, but may be quite useful when debugging C code that interfaces
** with Lua. A useful redefinition is to use assert.h.
*/

/*
@@ LUAI_BITSINT defines the number of bits in an int.
** CHANGE here if Lua cannot automatically detect the number of bits of
** your machine. Probably you do not need to change this.
*/
/* avoid overflows in comparison */

/* int has at least 32 bits */
enum LUAI_BITSINT = 32;

/*
@@ LUAI_UINT32 is an unsigned integer with at least 32 bits.
@@ LUAI_INT32 is an signed integer with at least 32 bits.
@@ LUAI_UMEM is an unsigned integer big enough to count the total
@* memory used by Lua.
@@ LUAI_MEM is a signed integer big enough to count the total memory
@* used by Lua.
** CHANGE here if for some weird reason the default definitions are not
** good enough for your machine. (The definitions in the 'else'
** part always works, but may waste space on machines with 64-bit
** longs.) Probably you do not need to change this.
*/
alias LUAI_UINT32 = uint;
alias LUAI_INT32 = int;
enum LUAI_MAXINT32 = INT_MAX;
alias LUAI_UMEM = size_t;
alias LUAI_MEM = ptrdiff_t;

/* 16-bit ints */

/*
@@ LUAI_MAXCALLS limits the number of nested calls.
** CHANGE it if you need really deep recursive calls. This limit is
** arbitrary; its only purpose is to stop infinite recursion before
** exhausting memory.
*/
enum LUAI_MAXCALLS = 20000;

/*
@@ LUAI_MAXCSTACK limits the number of Lua stack slots that a C function
@* can use.
** CHANGE it if you need lots of (Lua) stack space for your C
** functions. This limit is arbitrary; its only purpose is to stop C
** functions to consume unlimited stack space. (must be smaller than
** -LUA_REGISTRYINDEX)
*/
enum LUAI_MAXCSTACK = 8000;

/*
** {==================================================================
** CHANGE (to smaller values) the following definitions if your system
** has a small C stack. (Or you may want to change them to larger
** values if your system has a large C stack and these limits are
** too rigid for you.) Some of these constants control the size of
** stack-allocated arrays used by the compiler or the interpreter, while
** others limit the maximum number of recursive calls that the compiler
** or the interpreter can perform. Values too large may cause a C stack
** overflow for some forms of deep constructs.
** ===================================================================
*/

/*
@@ LUAI_MAXCCALLS is the maximum depth for nested C calls (short) and
@* syntactical nested non-terminals in a program.
*/
enum LUAI_MAXCCALLS = 200;

/*
@@ LUAI_MAXVARS is the maximum number of local variables per function
@* (must be smaller than 250).
*/
enum LUAI_MAXVARS = 200;

/*
@@ LUAI_MAXUPVALUES is the maximum number of upvalues per function
@* (must be smaller than 250).
*/
enum LUAI_MAXUPVALUES = 60;

/*
@@ LUAL_BUFFERSIZE is the buffer size used by the lauxlib buffer system.
*/
enum LUAL_BUFFERSIZE = BUFSIZ;

/* }================================================================== */

/*
** {==================================================================
@@ LUA_NUMBER is the type of numbers in Lua.
** CHANGE the following definitions only if you want to build Lua
** with a number type different from double. You may also need to
** change lua_number2int & lua_number2integer.
** ===================================================================
*/

alias LUA_NUMBER = double;

/*
@@ LUAI_UACNUMBER is the result of an 'usual argument conversion'
@* over a number.
*/
alias LUAI_UACNUMBER = double;

/*
@@ LUA_NUMBER_SCAN is the format for reading numbers.
@@ LUA_NUMBER_FMT is the format for writing numbers.
@@ lua_number2str converts a number to a string.
@@ LUAI_MAXNUMBER2STR is maximum size of previous conversion.
@@ lua_str2number converts a string to a number.
*/
enum LUA_NUMBER_SCAN = "%lf";
enum LUA_NUMBER_FMT = "%.14g";

extern (D) auto lua_number2str(T0, T1)(auto ref T0 s, auto ref T1 n)
{
    return sprintf(s, LUA_NUMBER_FMT, n);
}

enum LUAI_MAXNUMBER2STR = 32; /* 16 digits, sign, point, and \0 */
//alias lua_str2number = strtod; TODO

/*
@@ The luai_num* macros define the primitive operations over numbers.
*/

/*
@@ lua_number2int is a macro to convert lua_Number to int.
@@ lua_number2integer is a macro to convert lua_Number to lua_Integer.
** CHANGE them if you know a faster way to convert a lua_Number to
** int (with any rounding method and without throwing errors) in your
** system. In Pentium machines, a naive typecast from double to int
** in C is extremely slow, so any alternative is worth trying.
*/

/* On a Pentium, resort to a trick */

/* On a Microsoft compiler, use assembler */

/* the next trick should work on any Pentium, but sometimes clashes
   with a DirectX idiosyncrasy */

/* this option always works, but may be slow */

/* }================================================================== */

/*
@@ LUAI_USER_ALIGNMENT_T is a type that requires maximum alignment.
** CHANGE it if your system requires alignments larger than double. (For
** instance, if your system supports long doubles and they must be
** aligned in 16-byte boundaries, then you should add long double in the
** union.) Probably you do not need to change this.
*/

/*
@@ LUAI_THROW/LUAI_TRY define how Lua does exception handling.
** CHANGE them if you prefer to use longjmp/setjmp even with C++
** or if want/don't to use _longjmp/_setjmp instead of regular
** longjmp/setjmp. By default, Lua handles errors with exceptions when
** compiling as C++ code, with _longjmp/_setjmp when asked to use them,
** and with longjmp/setjmp otherwise.
*/

/* C++ exceptions */

/* dummy variable */

/* in Unix, try _longjmp/_setjmp (more efficient) */

/* default handling with long jumps */
extern (D) auto LUAI_THROW(T0, T1)(auto ref T0 L, auto ref T1 c)
{
    return longjmp(c.b, 1);
}

//enum luai_jmpbuf = jmp_buf;

/*
@@ LUA_MAXCAPTURES is the maximum number of captures that a pattern
@* can do during pattern-matching.
** CHANGE it if you need more captures. This limit is arbitrary.
*/
enum LUA_MAXCAPTURES = 32;

/*
@@ lua_tmpnam is the function that the OS library uses to create a
@* temporary name.
@@ LUA_TMPNAMBUFSIZE is the maximum size of a name created by lua_tmpnam.
** CHANGE them if you have an alternative to tmpnam (which is considered
** insecure) or if you want the original tmpnam anyway.  By default, Lua
** uses tmpnam except when POSIX is available, where it uses mkstemp.
*/

/*
@@ lua_popen spawns a new process connected to the current one through
@* the file streams.
** CHANGE it if you have a way to implement it in your system.
*/

/*
@@ LUA_DL_* define which dynamic-library system Lua should use.
** CHANGE here if Lua has problems choosing the appropriate
** dynamic-library system for your platform (either Windows' DLL, Mac's
** dyld, or Unix's dlopen). If your system is some kind of Unix, there
** is a good chance that it has dlopen, so LUA_DL_DLOPEN will work for
** it.  To use dlopen you also need to adapt the src/Makefile (probably
** adding -ldl to the linker options), so Lua does not select it
** automatically.  (When you change the makefile to add -ldl, you must
** also add -DLUA_USE_DLOPEN.)
** If you do not want any kind of dynamic library, undefine all these
** options.
** By default, _WIN32 gets LUA_DL_DLL and MAC OS X gets LUA_DL_DYLD.
*/

/*
@@ LUAI_EXTRASPACE allows you to add user-specific data in a lua_State
@* (the data goes just *before* the lua_State pointer).
** CHANGE (define) this if you really need that. This value must be
** a multiple of the maximum alignment required for your machine.
*/
enum LUAI_EXTRASPACE = 0;

/*
@@ luai_userstate* allow user-specific actions on threads.
** CHANGE them if you defined LUAI_EXTRASPACE and need to do something
** extra when a thread is created/deleted/resumed/yielded.
*/
extern (D) auto luai_userstateopen(T)(auto ref T L)
{
    return cast(void) L;
}

extern (D) auto luai_userstateclose(T)(auto ref T L)
{
    return cast(void) L;
}

extern (D) auto luai_userstatethread(T0, T1)(auto ref T0 L, auto ref T1 L1)
{
    return cast(void) L;
}

extern (D) auto luai_userstatefree(T)(auto ref T L)
{
    return cast(void) L;
}

extern (D) auto luai_userstateresume(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return cast(void) L;
}

extern (D) auto luai_userstateyield(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return cast(void) L;
}

/*
@@ LUA_INTFRMLEN is the length modifier for integer conversions
@* in 'string.format'.
@@ LUA_INTFRM_T is the integer type correspoding to the previous length
@* modifier.
** CHANGE them if your system supports long long or does not support long.
*/

enum LUA_INTFRMLEN = "l";
alias LUA_INTFRM_T = c_long;

/* =================================================================== */

/*
** Local configuration. You can use this space to add your redefinitions
** without modifying the main part of the file.
*/

enum LUA_VERSION = "Lua 5.1";
enum LUA_RELEASE = "Lua 5.1.5";
enum LUA_VERSION_NUM = 501;
enum LUA_COPYRIGHT = "Copyright (C) 1994-2012 Lua.org, PUC-Rio";
enum LUA_AUTHORS = "R. Ierusalimschy, L. H. de Figueiredo & W. Celes";

/* mark for precompiled code (`<esc>Lua') */
enum LUA_SIGNATURE = "\033Lua";

/* option for multiple returns in `lua_pcall' and `lua_call' */
enum LUA_MULTRET = -1;

/*
** pseudo-indices
*/
enum LUA_REGISTRYINDEX = -10000;
enum LUA_ENVIRONINDEX = -10001;
enum LUA_GLOBALSINDEX = -10002;

extern (D) auto lua_upvalueindex(T)(auto ref T i)
{
    return LUA_GLOBALSINDEX - i;
}

/* thread status; 0 is OK */
enum LUA_YIELD = 1;
enum LUA_ERRRUN = 2;
enum LUA_ERRSYNTAX = 3;
enum LUA_ERRMEM = 4;
enum LUA_ERRERR = 5;

struct lua_State;

alias lua_CFunction = int function (lua_State* L);

/*
** functions that read/write blocks when loading/dumping Lua chunks
*/
alias lua_Reader = const(char)* function (lua_State* L, void* ud, size_t* sz);

alias lua_Writer = int function (lua_State* L, const(void)* p, size_t sz, void* ud);

/*
** prototype for memory-allocation functions
*/
alias lua_Alloc = void* function (void* ud, void* ptr, size_t osize, size_t nsize);

/*
** basic types
*/
enum LUA_TNONE = -1;

enum LUA_TNIL = 0;
enum LUA_TBOOLEAN = 1;
enum LUA_TLIGHTUSERDATA = 2;
enum LUA_TNUMBER = 3;
enum LUA_TSTRING = 4;
enum LUA_TTABLE = 5;
enum LUA_TFUNCTION = 6;
enum LUA_TUSERDATA = 7;
enum LUA_TTHREAD = 8;

/* minimum Lua stack available to a C function */
enum LUA_MINSTACK = 20;

/*
** generic extra include file
*/

/* type of numbers in Lua */
alias lua_Number = double;

/* type for integer functions */
alias lua_Integer = c_long;

/*
** state manipulation
*/
lua_State* lua_newstate (lua_Alloc f, void* ud);
void lua_close (lua_State* L);
lua_State* lua_newthread (lua_State* L);

lua_CFunction lua_atpanic (lua_State* L, lua_CFunction panicf);

/*
** basic stack manipulation
*/
int lua_gettop (lua_State* L);
void lua_settop (lua_State* L, int idx);
void lua_pushvalue (lua_State* L, int idx);
void lua_remove (lua_State* L, int idx);
void lua_insert (lua_State* L, int idx);
void lua_replace (lua_State* L, int idx);
int lua_checkstack (lua_State* L, int sz);

void lua_xmove (lua_State* from, lua_State* to, int n);

/*
** access functions (stack -> C)
*/

int lua_isnumber (lua_State* L, int idx);
int lua_isstring (lua_State* L, int idx);
int lua_iscfunction (lua_State* L, int idx);
int lua_isuserdata (lua_State* L, int idx);
int lua_type (lua_State* L, int idx);
const(char)* lua_typename (lua_State* L, int tp);

int lua_equal (lua_State* L, int idx1, int idx2);
int lua_rawequal (lua_State* L, int idx1, int idx2);
int lua_lessthan (lua_State* L, int idx1, int idx2);

lua_Number lua_tonumber (lua_State* L, int idx);
lua_Integer lua_tointeger (lua_State* L, int idx);
int lua_toboolean (lua_State* L, int idx);
const(char)* lua_tolstring (lua_State* L, int idx, size_t* len);
size_t lua_objlen (lua_State* L, int idx);
lua_CFunction lua_tocfunction (lua_State* L, int idx);
void* lua_touserdata (lua_State* L, int idx);
lua_State* lua_tothread (lua_State* L, int idx);
const(void)* lua_topointer (lua_State* L, int idx);

/*
** push functions (C -> stack)
*/
void lua_pushnil (lua_State* L);
void lua_pushnumber (lua_State* L, lua_Number n);
void lua_pushinteger (lua_State* L, lua_Integer n);
void lua_pushlstring (lua_State* L, const(char)* s, size_t l);
void lua_pushstring (lua_State* L, const(char)* s);
const(char)* lua_pushvfstring (lua_State* L, const(char)* fmt, va_list argp);
const(char)* lua_pushfstring (lua_State* L, const(char)* fmt, ...);
void lua_pushcclosure (lua_State* L, lua_CFunction fn, int n);
void lua_pushboolean (lua_State* L, int b);
void lua_pushlightuserdata (lua_State* L, void* p);
int lua_pushthread (lua_State* L);

/*
** get functions (Lua -> stack)
*/
void lua_gettable (lua_State* L, int idx);
void lua_getfield (lua_State* L, int idx, const(char)* k);
void lua_rawget (lua_State* L, int idx);
void lua_rawgeti (lua_State* L, int idx, int n);
void lua_createtable (lua_State* L, int narr, int nrec);
void* lua_newuserdata (lua_State* L, size_t sz);
int lua_getmetatable (lua_State* L, int objindex);
void lua_getfenv (lua_State* L, int idx);

/*
** set functions (stack -> Lua)
*/
void lua_settable (lua_State* L, int idx);
void lua_setfield (lua_State* L, int idx, const(char)* k);
void lua_rawset (lua_State* L, int idx);
void lua_rawseti (lua_State* L, int idx, int n);
int lua_setmetatable (lua_State* L, int objindex);
int lua_setfenv (lua_State* L, int idx);

/*
** `load' and `call' functions (load and run Lua code)
*/
void lua_call (lua_State* L, int nargs, int nresults);
int lua_pcall (lua_State* L, int nargs, int nresults, int errfunc);
int lua_cpcall (lua_State* L, lua_CFunction func, void* ud);
int lua_load (
    lua_State* L,
    lua_Reader reader,
    void* dt,
    const(char)* chunkname);

int lua_dump (lua_State* L, lua_Writer writer, void* data);

/*
** coroutine functions
*/
int lua_yield (lua_State* L, int nresults);
int lua_resume (lua_State* L, int narg);
int lua_status (lua_State* L);

/*
** garbage-collection function and options
*/

enum LUA_GCSTOP = 0;
enum LUA_GCRESTART = 1;
enum LUA_GCCOLLECT = 2;
enum LUA_GCCOUNT = 3;
enum LUA_GCCOUNTB = 4;
enum LUA_GCSTEP = 5;
enum LUA_GCSETPAUSE = 6;
enum LUA_GCSETSTEPMUL = 7;

int lua_gc (lua_State* L, int what, int data);

/*
** miscellaneous functions
*/

int lua_error (lua_State* L);

int lua_next (lua_State* L, int idx);

void lua_concat (lua_State* L, int n);

lua_Alloc lua_getallocf (lua_State* L, void** ud);
void lua_setallocf (lua_State* L, lua_Alloc f, void* ud);

/*
** ===============================================================
** some useful macros
** ===============================================================
*/

extern (D) auto lua_pop(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return lua_settop(L, -n - 1);
}

extern (D) auto lua_newtable(T)(auto ref T L)
{
    return lua_createtable(L, 0, 0);
}

extern (D) auto lua_pushcfunction(T0, T1)(auto ref T0 L, auto ref T1 f)
{
    return lua_pushcclosure(L, f, 0);
}

alias lua_strlen = lua_objlen;

extern (D) auto lua_isfunction(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return lua_type(L, n) == LUA_TFUNCTION;
}

extern (D) auto lua_istable(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return lua_type(L, n) == LUA_TTABLE;
}

extern (D) auto lua_islightuserdata(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return lua_type(L, n) == LUA_TLIGHTUSERDATA;
}

extern (D) auto lua_isnil(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return lua_type(L, n) == LUA_TNIL;
}

extern (D) auto lua_isboolean(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return lua_type(L, n) == LUA_TBOOLEAN;
}

extern (D) auto lua_isthread(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return lua_type(L, n) == LUA_TTHREAD;
}

extern (D) auto lua_isnone(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return lua_type(L, n) == LUA_TNONE;
}

extern (D) auto lua_isnoneornil(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return lua_type(L, n) <= 0;
}

extern (D) auto lua_setglobal(T0, T1)(auto ref T0 L, auto ref T1 s)
{
    return lua_setfield(L, LUA_GLOBALSINDEX, s);
}

extern (D) auto lua_getglobal(T0, T1)(auto ref T0 L, auto ref T1 s)
{
    return lua_getfield(L, LUA_GLOBALSINDEX, s);
}

extern (D) auto lua_tostring(T0, T1)(auto ref T0 L, auto ref T1 i)
{
    return lua_tolstring(L, i, NULL);
}

/*
** compatibility macros and functions
*/

alias lua_open = luaL_newstate;

extern (D) auto lua_getregistry(T)(auto ref T L)
{
    return lua_pushvalue(L, LUA_REGISTRYINDEX);
}

extern (D) auto lua_getgccount(T)(auto ref T L)
{
    return lua_gc(L, LUA_GCCOUNT, 0);
}

alias lua_Chunkreader = lua_Reader;
alias lua_Chunkwriter = lua_Writer;

/* hack */
void lua_setlevel (lua_State* from, lua_State* to);

/*
** {======================================================================
** Debug API
** =======================================================================
*/

/*
** Event codes
*/
enum LUA_HOOKCALL = 0;
enum LUA_HOOKRET = 1;
enum LUA_HOOKLINE = 2;
enum LUA_HOOKCOUNT = 3;
enum LUA_HOOKTAILRET = 4;

/*
** Event masks
*/
enum LUA_MASKCALL = 1 << LUA_HOOKCALL;
enum LUA_MASKRET = 1 << LUA_HOOKRET;
enum LUA_MASKLINE = 1 << LUA_HOOKLINE;
enum LUA_MASKCOUNT = 1 << LUA_HOOKCOUNT; /* activation record */

/* Functions to be called by the debuger in specific events */
alias lua_Hook = void function (lua_State* L, lua_Debug* ar);

int lua_getstack (lua_State* L, int level, lua_Debug* ar);
int lua_getinfo (lua_State* L, const(char)* what, lua_Debug* ar);
const(char)* lua_getlocal (lua_State* L, const(lua_Debug)* ar, int n);
const(char)* lua_setlocal (lua_State* L, const(lua_Debug)* ar, int n);
const(char)* lua_getupvalue (lua_State* L, int funcindex, int n);
const(char)* lua_setupvalue (lua_State* L, int funcindex, int n);

int lua_sethook (lua_State* L, lua_Hook func, int mask, int count);
lua_Hook lua_gethook (lua_State* L);
int lua_gethookmask (lua_State* L);
int lua_gethookcount (lua_State* L);

struct lua_Debug
{
    int event;
    const(char)* name; /* (n) */
    const(char)* namewhat; /* (n) `global', `local', `field', `method' */
    const(char)* what; /* (S) `Lua', `C', `main', `tail' */
    const(char)* source; /* (S) */
    int currentline; /* (l) */
    int nups; /* (u) number of upvalues */
    int linedefined; /* (S) */
    int lastlinedefined; /* (S) */
    char[LUA_IDSIZE] short_src; /* (S) */
    /* private part */
    int i_ci; /* active function */
}

/* }====================================================================== */

/******************************************************************************
* Copyright (C) 1994-2012 Lua.org, PUC-Rio.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining
* a copy of this software and associated documentation files (the
* "Software"), to deal in the Software without restriction, including
* without limitation the rights to use, copy, modify, merge, publish,
* distribute, sublicense, and/or sell copies of the Software, and to
* permit persons to whom the Software is furnished to do so, subject to
* the following conditions:
*
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
******************************************************************************/

/*
** $Id: lualib.h,v 1.36.1.1 2007/12/27 13:02:25 roberto Exp $
** Lua standard libraries
** See Copyright Notice in lua.h
*/

/* Key to file-handle type */

/* open all previous libraries */

/*
** $Id: lauxlib.h,v 1.88.1.1 2007/12/27 13:02:25 roberto Exp $
** Auxiliary functions for building Lua libraries
** See Copyright Notice in lua.h
*/

extern (D) auto luaL_getn(T0, T1)(auto ref T0 L, auto ref T1 i)
{
    return cast(int) lua_objlen(L, i);
}

extern (D) auto luaL_setn(T0, T1, T2)(auto ref T0 L, auto ref T1 i, auto ref T2 j)
{
    return cast(void) 0;
} /* no op! */

/* extra error code for `luaL_load' */
enum LUA_ERRFILE = LUA_ERRERR + 1;

struct luaL_Reg
{
    const(char)* name;
    lua_CFunction func;
}

void luaL_openlib (
    lua_State* L,
    const(char)* libname,
    const(luaL_Reg)* l,
    int nup);
void luaL_register (lua_State* L, const(char)* libname, const(luaL_Reg)* l);
int luaL_getmetafield (lua_State* L, int obj, const(char)* e);
int luaL_callmeta (lua_State* L, int obj, const(char)* e);
int luaL_typerror (lua_State* L, int narg, const(char)* tname);
int luaL_argerror (lua_State* L, int numarg, const(char)* extramsg);
const(char)* luaL_checklstring (lua_State* L, int numArg, size_t* l);
const(char)* luaL_optlstring (
    lua_State* L,
    int numArg,
    const(char)* def,
    size_t* l);
lua_Number luaL_checknumber (lua_State* L, int numArg);
lua_Number luaL_optnumber (lua_State* L, int nArg, lua_Number def);

lua_Integer luaL_checkinteger (lua_State* L, int numArg);
lua_Integer luaL_optinteger (lua_State* L, int nArg, lua_Integer def);

void luaL_checkstack (lua_State* L, int sz, const(char)* msg);
void luaL_checktype (lua_State* L, int narg, int t);
void luaL_checkany (lua_State* L, int narg);

int luaL_newmetatable (lua_State* L, const(char)* tname);
void* luaL_checkudata (lua_State* L, int ud, const(char)* tname);

void luaL_where (lua_State* L, int lvl);
int luaL_error (lua_State* L, const(char)* fmt, ...);

int luaL_checkoption (
    lua_State* L,
    int narg,
    const(char)* def,
    const(char*)* lst);

int luaL_ref (lua_State* L, int t);
void luaL_unref (lua_State* L, int t, int ref_);

int luaL_loadfile (lua_State* L, const(char)* filename);
int luaL_loadbuffer (
    lua_State* L,
    const(char)* buff,
    size_t sz,
    const(char)* name);
int luaL_loadstring (lua_State* L, const(char)* s);

lua_State* luaL_newstate ();

const(char)* luaL_gsub (
    lua_State* L,
    const(char)* s,
    const(char)* p,
    const(char)* r);

const(char)* luaL_findtable (
    lua_State* L,
    int idx,
    const(char)* fname,
    int szhint);

/*
** ===============================================================
** some useful macros
** ===============================================================
*/

extern (D) auto luaL_argcheck(T0, T1, T2, T3)(auto ref T0 L, auto ref T1 cond, auto ref T2 numarg, auto ref T3 extramsg)
{
    return cast(void) cond || luaL_argerror(L, numarg, extramsg);
}

extern (D) auto luaL_checkstring(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return luaL_checklstring(L, n, NULL);
}

extern (D) auto luaL_optstring(T0, T1, T2)(auto ref T0 L, auto ref T1 n, auto ref T2 d)
{
    return luaL_optlstring(L, n, d, NULL);
}

extern (D) auto luaL_checkint(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return cast(int) luaL_checkinteger(L, n);
}

extern (D) auto luaL_optint(T0, T1, T2)(auto ref T0 L, auto ref T1 n, auto ref T2 d)
{
    return cast(int) luaL_optinteger(L, n, d);
}

extern (D) auto luaL_checklong(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return cast(c_long) luaL_checkinteger(L, n);
}

extern (D) auto luaL_optlong(T0, T1, T2)(auto ref T0 L, auto ref T1 n, auto ref T2 d)
{
    return cast(c_long) luaL_optinteger(L, n, d);
}

extern (D) auto luaL_typename(T0, T1)(auto ref T0 L, auto ref T1 i)
{
    return lua_typename(L, lua_type(L, i));
}

extern (D) auto luaL_dofile(T0, T1)(auto ref T0 L, auto ref T1 fn)
{
    return luaL_loadfile(L, fn) || lua_pcall(L, 0, LUA_MULTRET, 0);
}

extern (D) auto luaL_dostring(T0, T1)(auto ref T0 L, auto ref T1 s)
{
    return luaL_loadstring(L, s) || lua_pcall(L, 0, LUA_MULTRET, 0);
}

extern (D) auto luaL_getmetatable(T0, T1)(auto ref T0 L, auto ref T1 n)
{
    return lua_getfield(L, LUA_REGISTRYINDEX, n);
}

extern (D) auto luaL_opt(T0, T1, T2, T3)(auto ref T0 L, auto ref T1 f, auto ref T2 n, auto ref T3 d)
{
    return lua_isnoneornil(L, n) ? d : f(L, n);
}

/*
** {======================================================
** Generic Buffer manipulation
** =======================================================
*/

struct luaL_Buffer
{
    char* p; /* current position in buffer */
    int lvl; /* number of strings in the stack (level) */
    lua_State* L;
    char[LUAL_BUFFERSIZE] buffer;
}

// TODO:
/* #define luaL_addchar(B,c) \
  ((void)((B)->p < ((B)->buffer+LUAL_BUFFERSIZE) || luaL_prepbuffer(B)), \
   (*(B)->p++ = (char)(c)))
*/

/* compatibility only */
//alias luaL_putchar = luaL_addchar; 

void luaL_buffinit (lua_State* L, luaL_Buffer* B);
char* luaL_prepbuffer (luaL_Buffer* B);
void luaL_addlstring (luaL_Buffer* B, const(char)* s, size_t l);
void luaL_addstring (luaL_Buffer* B, const(char)* s);
void luaL_addvalue (luaL_Buffer* B);
void luaL_pushresult (luaL_Buffer* B);
int luaopen_base (lua_State* L);
int luaopen_table (lua_State* L);
int luaopen_io (lua_State* L);
int luaopen_os (lua_State* L);
int luaopen_string (lua_State* L);
int luaopen_math (lua_State* L);
int luaopen_debug (lua_State* L);
int luaopen_package (lua_State* L);
void luaL_openlibs (lua_State* L);

/* }====================================================== */

/* compatibility with ref system */

/* pre-defined references */
enum LUA_NOREF = -2;
enum LUA_REFNIL = -1;

extern (D) auto lua_unref(T0, T1)(auto ref T0 L, auto ref T1 _ref)
{
    return luaL_unref(L, LUA_REGISTRYINDEX, _ref);
}

extern (D) auto lua_getref(T0, T1)(auto ref T0 L, auto ref T1 _ref)
{
    return lua_rawgeti(L, LUA_REGISTRYINDEX, _ref);
}

alias luaL_reg = luaL_Reg;
enum LUA_FILEHANDLE = "FILE*";
enum LUA_COLIBNAME = "coroutine";
enum LUA_TABLIBNAME = "table";
enum LUA_IOLIBNAME = "io";
enum LUA_OSLIBNAME = "os";
enum LUA_STRLIBNAME = "string";
enum LUA_MATHLIBNAME = "math";
enum LUA_DBLIBNAME = "debug";
enum LUA_LOADLIBNAME = "package";

extern (D) auto lua_assert(T)(auto ref T x)
{
    return cast(void) 0;
}
