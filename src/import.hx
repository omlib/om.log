import haxe.Json;

#if sys
import sys.FileSystem;
import sys.io.File;
#elseif nodejs
import js.node.Fs;
#end

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.PositionTools;
using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
using om.macro.MacroTools;
#end

using StringTools;
