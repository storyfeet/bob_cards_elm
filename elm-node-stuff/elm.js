(function(scope){
'use strict';

function F(arity, fun, wrapper) {
  wrapper.a = arity;
  wrapper.f = fun;
  return wrapper;
}

function F2(fun) {
  return F(2, fun, function(a) { return function(b) { return fun(a,b); }; })
}
function F3(fun) {
  return F(3, fun, function(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  });
}
function F4(fun) {
  return F(4, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  });
}
function F5(fun) {
  return F(5, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  });
}
function F6(fun) {
  return F(6, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  });
}
function F7(fun) {
  return F(7, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  });
}
function F8(fun) {
  return F(8, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  });
}
function F9(fun) {
  return F(9, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  });
}

function A2(fun, a, b) {
  return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
  return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
  return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
  return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
  return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
  return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
  return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
  return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

console.warn('Compiled in DEV mode. Follow the advice at https://elm-lang.org/0.19.1/optimize for better performance and smaller assets.');


var _List_Nil_UNUSED = { $: 0 };
var _List_Nil = { $: '[]' };

function _List_Cons_UNUSED(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons(hd, tl) { return { $: '::', a: hd, b: tl }; }


var _List_cons = F2(_List_Cons);

function _List_fromArray(arr)
{
	var out = _List_Nil;
	for (var i = arr.length; i--; )
	{
		out = _List_Cons(arr[i], out);
	}
	return out;
}

function _List_toArray(xs)
{
	for (var out = []; xs.b; xs = xs.b) // WHILE_CONS
	{
		out.push(xs.a);
	}
	return out;
}

var _List_map2 = F3(function(f, xs, ys)
{
	for (var arr = []; xs.b && ys.b; xs = xs.b, ys = ys.b) // WHILE_CONSES
	{
		arr.push(A2(f, xs.a, ys.a));
	}
	return _List_fromArray(arr);
});

var _List_map3 = F4(function(f, xs, ys, zs)
{
	for (var arr = []; xs.b && ys.b && zs.b; xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A3(f, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map4 = F5(function(f, ws, xs, ys, zs)
{
	for (var arr = []; ws.b && xs.b && ys.b && zs.b; ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A4(f, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map5 = F6(function(f, vs, ws, xs, ys, zs)
{
	for (var arr = []; vs.b && ws.b && xs.b && ys.b && zs.b; vs = vs.b, ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A5(f, vs.a, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_sortBy = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		return _Utils_cmp(f(a), f(b));
	}));
});

var _List_sortWith = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		var ord = A2(f, a, b);
		return ord === $elm$core$Basics$EQ ? 0 : ord === $elm$core$Basics$LT ? -1 : 1;
	}));
});



var _JsArray_empty = [];

function _JsArray_singleton(value)
{
    return [value];
}

function _JsArray_length(array)
{
    return array.length;
}

var _JsArray_initialize = F3(function(size, offset, func)
{
    var result = new Array(size);

    for (var i = 0; i < size; i++)
    {
        result[i] = func(offset + i);
    }

    return result;
});

var _JsArray_initializeFromList = F2(function (max, ls)
{
    var result = new Array(max);

    for (var i = 0; i < max && ls.b; i++)
    {
        result[i] = ls.a;
        ls = ls.b;
    }

    result.length = i;
    return _Utils_Tuple2(result, ls);
});

var _JsArray_unsafeGet = F2(function(index, array)
{
    return array[index];
});

var _JsArray_unsafeSet = F3(function(index, value, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[index] = value;
    return result;
});

var _JsArray_push = F2(function(value, array)
{
    var length = array.length;
    var result = new Array(length + 1);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[length] = value;
    return result;
});

var _JsArray_foldl = F3(function(func, acc, array)
{
    var length = array.length;

    for (var i = 0; i < length; i++)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_foldr = F3(function(func, acc, array)
{
    for (var i = array.length - 1; i >= 0; i--)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_map = F2(function(func, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = func(array[i]);
    }

    return result;
});

var _JsArray_indexedMap = F3(function(func, offset, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = A2(func, offset + i, array[i]);
    }

    return result;
});

var _JsArray_slice = F3(function(from, to, array)
{
    return array.slice(from, to);
});

var _JsArray_appendN = F3(function(n, dest, source)
{
    var destLen = dest.length;
    var itemsToCopy = n - destLen;

    if (itemsToCopy > source.length)
    {
        itemsToCopy = source.length;
    }

    var size = destLen + itemsToCopy;
    var result = new Array(size);

    for (var i = 0; i < destLen; i++)
    {
        result[i] = dest[i];
    }

    for (var i = 0; i < itemsToCopy; i++)
    {
        result[i + destLen] = source[i];
    }

    return result;
});



// LOG

var _Debug_log_UNUSED = F2(function(tag, value)
{
	return value;
});

var _Debug_log = F2(function(tag, value)
{
	console.log(tag + ': ' + _Debug_toString(value));
	return value;
});


// TODOS

function _Debug_todo(moduleName, region)
{
	return function(message) {
		_Debug_crash(8, moduleName, region, message);
	};
}

function _Debug_todoCase(moduleName, region, value)
{
	return function(message) {
		_Debug_crash(9, moduleName, region, value, message);
	};
}


// TO STRING

function _Debug_toString_UNUSED(value)
{
	return '<internals>';
}

function _Debug_toString(value)
{
	return _Debug_toAnsiString(false, value);
}

function _Debug_toAnsiString(ansi, value)
{
	if (typeof value === 'function')
	{
		return _Debug_internalColor(ansi, '<function>');
	}

	if (typeof value === 'boolean')
	{
		return _Debug_ctorColor(ansi, value ? 'True' : 'False');
	}

	if (typeof value === 'number')
	{
		return _Debug_numberColor(ansi, value + '');
	}

	if (value instanceof String)
	{
		return _Debug_charColor(ansi, "'" + _Debug_addSlashes(value, true) + "'");
	}

	if (typeof value === 'string')
	{
		return _Debug_stringColor(ansi, '"' + _Debug_addSlashes(value, false) + '"');
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (typeof tag === 'number')
		{
			return _Debug_internalColor(ansi, '<internals>');
		}

		if (tag[0] === '#')
		{
			var output = [];
			for (var k in value)
			{
				if (k === '$') continue;
				output.push(_Debug_toAnsiString(ansi, value[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (tag === 'Set_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Set')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Set$toList(value));
		}

		if (tag === 'RBNode_elm_builtin' || tag === 'RBEmpty_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Dict')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Dict$toList(value));
		}

		if (tag === 'Array_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Array')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Array$toList(value));
		}

		if (tag === '::' || tag === '[]')
		{
			var output = '[';

			value.b && (output += _Debug_toAnsiString(ansi, value.a), value = value.b)

			for (; value.b; value = value.b) // WHILE_CONS
			{
				output += ',' + _Debug_toAnsiString(ansi, value.a);
			}
			return output + ']';
		}

		var output = '';
		for (var i in value)
		{
			if (i === '$') continue;
			var str = _Debug_toAnsiString(ansi, value[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '[' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return _Debug_ctorColor(ansi, tag) + output;
	}

	if (typeof DataView === 'function' && value instanceof DataView)
	{
		return _Debug_stringColor(ansi, '<' + value.byteLength + ' bytes>');
	}

	if (typeof File !== 'undefined' && value instanceof File)
	{
		return _Debug_internalColor(ansi, '<' + value.name + '>');
	}

	if (typeof value === 'object')
	{
		var output = [];
		for (var key in value)
		{
			var field = key[0] === '_' ? key.slice(1) : key;
			output.push(_Debug_fadeColor(ansi, field) + ' = ' + _Debug_toAnsiString(ansi, value[key]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return _Debug_internalColor(ansi, '<internals>');
}

function _Debug_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');

	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}

function _Debug_ctorColor(ansi, string)
{
	return ansi ? '\x1b[96m' + string + '\x1b[0m' : string;
}

function _Debug_numberColor(ansi, string)
{
	return ansi ? '\x1b[95m' + string + '\x1b[0m' : string;
}

function _Debug_stringColor(ansi, string)
{
	return ansi ? '\x1b[93m' + string + '\x1b[0m' : string;
}

function _Debug_charColor(ansi, string)
{
	return ansi ? '\x1b[92m' + string + '\x1b[0m' : string;
}

function _Debug_fadeColor(ansi, string)
{
	return ansi ? '\x1b[37m' + string + '\x1b[0m' : string;
}

function _Debug_internalColor(ansi, string)
{
	return ansi ? '\x1b[36m' + string + '\x1b[0m' : string;
}

function _Debug_toHexDigit(n)
{
	return String.fromCharCode(n < 10 ? 48 + n : 55 + n);
}


// CRASH


function _Debug_crash_UNUSED(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash(identifier, fact1, fact2, fact3, fact4)
{
	switch(identifier)
	{
		case 0:
			throw new Error('What node should I take over? In JavaScript I need something like:\n\n    Elm.Main.init({\n        node: document.getElementById("elm-node")\n    })\n\nYou need to do this with any Browser.sandbox or Browser.element program.');

		case 1:
			throw new Error('Browser.application programs cannot handle URLs like this:\n\n    ' + document.location.href + '\n\nWhat is the root? The root of your file system? Try looking at this program with `elm reactor` or some other server.');

		case 2:
			var jsonErrorString = fact1;
			throw new Error('Problem with the flags given to your Elm program on initialization.\n\n' + jsonErrorString);

		case 3:
			var portName = fact1;
			throw new Error('There can only be one port named `' + portName + '`, but your program has multiple.');

		case 4:
			var portName = fact1;
			var problem = fact2;
			throw new Error('Trying to send an unexpected type of value through port `' + portName + '`:\n' + problem);

		case 5:
			throw new Error('Trying to use `(==)` on functions.\nThere is no way to know if functions are "the same" in the Elm sense.\nRead more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.');

		case 6:
			var moduleName = fact1;
			throw new Error('Your page is loading multiple Elm scripts with a module named ' + moduleName + '. Maybe a duplicate script is getting loaded accidentally? If not, rename one of them so I know which is which!');

		case 8:
			var moduleName = fact1;
			var region = fact2;
			var message = fact3;
			throw new Error('TODO in module `' + moduleName + '` ' + _Debug_regionToString(region) + '\n\n' + message);

		case 9:
			var moduleName = fact1;
			var region = fact2;
			var value = fact3;
			var message = fact4;
			throw new Error(
				'TODO in module `' + moduleName + '` from the `case` expression '
				+ _Debug_regionToString(region) + '\n\nIt received the following value:\n\n    '
				+ _Debug_toString(value).replace('\n', '\n    ')
				+ '\n\nBut the branch that handles it says:\n\n    ' + message.replace('\n', '\n    ')
			);

		case 10:
			throw new Error('Bug in https://github.com/elm/virtual-dom/issues');

		case 11:
			throw new Error('Cannot perform mod 0. Division by zero error.');
	}
}

function _Debug_regionToString(region)
{
	if (region.start.line === region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'on lines ' + region.start.line + ' through ' + region.end.line;
}



// EQUALITY

function _Utils_eq(x, y)
{
	for (
		var pair, stack = [], isEqual = _Utils_eqHelp(x, y, 0, stack);
		isEqual && (pair = stack.pop());
		isEqual = _Utils_eqHelp(pair.a, pair.b, 0, stack)
		)
	{}

	return isEqual;
}

function _Utils_eqHelp(x, y, depth, stack)
{
	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object' || x === null || y === null)
	{
		typeof x === 'function' && _Debug_crash(5);
		return false;
	}

	if (depth > 100)
	{
		stack.push(_Utils_Tuple2(x,y));
		return true;
	}

	/**/
	if (x.$ === 'Set_elm_builtin')
	{
		x = $elm$core$Set$toList(x);
		y = $elm$core$Set$toList(y);
	}
	if (x.$ === 'RBNode_elm_builtin' || x.$ === 'RBEmpty_elm_builtin')
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	/**_UNUSED/
	if (x.$ < 0)
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	for (var key in x)
	{
		if (!_Utils_eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

var _Utils_equal = F2(_Utils_eq);
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });



// COMPARISONS

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

function _Utils_cmp(x, y, ord)
{
	if (typeof x !== 'object')
	{
		return x === y ? /*EQ*/ 0 : x < y ? /*LT*/ -1 : /*GT*/ 1;
	}

	/**/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**_UNUSED/
	if (typeof x.$ === 'undefined')
	//*/
	/**/
	if (x.$[0] === '#')
	//*/
	{
		return (ord = _Utils_cmp(x.a, y.a))
			? ord
			: (ord = _Utils_cmp(x.b, y.b))
				? ord
				: _Utils_cmp(x.c, y.c);
	}

	// traverse conses until end of a list or a mismatch
	for (; x.b && y.b && !(ord = _Utils_cmp(x.a, y.a)); x = x.b, y = y.b) {} // WHILE_CONSES
	return ord || (x.b ? /*GT*/ 1 : y.b ? /*LT*/ -1 : /*EQ*/ 0);
}

var _Utils_lt = F2(function(a, b) { return _Utils_cmp(a, b) < 0; });
var _Utils_le = F2(function(a, b) { return _Utils_cmp(a, b) < 1; });
var _Utils_gt = F2(function(a, b) { return _Utils_cmp(a, b) > 0; });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });

var _Utils_compare = F2(function(x, y)
{
	var n = _Utils_cmp(x, y);
	return n < 0 ? $elm$core$Basics$LT : n ? $elm$core$Basics$GT : $elm$core$Basics$EQ;
});


// COMMON VALUES

var _Utils_Tuple0_UNUSED = 0;
var _Utils_Tuple0 = { $: '#0' };

function _Utils_Tuple2_UNUSED(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3_UNUSED(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr_UNUSED(c) { return c; }
function _Utils_chr(c) { return new String(c); }


// RECORDS

function _Utils_update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


// APPEND

var _Utils_append = F2(_Utils_ap);

function _Utils_ap(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (!xs.b)
	{
		return ys;
	}
	var root = _List_Cons(xs.a, ys);
	xs = xs.b
	for (var curr = root; xs.b; xs = xs.b) // WHILE_CONS
	{
		curr = curr.b = _List_Cons(xs.a, ys);
	}
	return root;
}



// MATH

var _Basics_add = F2(function(a, b) { return a + b; });
var _Basics_sub = F2(function(a, b) { return a - b; });
var _Basics_mul = F2(function(a, b) { return a * b; });
var _Basics_fdiv = F2(function(a, b) { return a / b; });
var _Basics_idiv = F2(function(a, b) { return (a / b) | 0; });
var _Basics_pow = F2(Math.pow);

var _Basics_remainderBy = F2(function(b, a) { return a % b; });

// https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
var _Basics_modBy = F2(function(modulus, x)
{
	var answer = x % modulus;
	return modulus === 0
		? _Debug_crash(11)
		:
	((answer > 0 && modulus < 0) || (answer < 0 && modulus > 0))
		? answer + modulus
		: answer;
});


// TRIGONOMETRY

var _Basics_pi = Math.PI;
var _Basics_e = Math.E;
var _Basics_cos = Math.cos;
var _Basics_sin = Math.sin;
var _Basics_tan = Math.tan;
var _Basics_acos = Math.acos;
var _Basics_asin = Math.asin;
var _Basics_atan = Math.atan;
var _Basics_atan2 = F2(Math.atan2);


// MORE MATH

function _Basics_toFloat(x) { return x; }
function _Basics_truncate(n) { return n | 0; }
function _Basics_isInfinite(n) { return n === Infinity || n === -Infinity; }

var _Basics_ceiling = Math.ceil;
var _Basics_floor = Math.floor;
var _Basics_round = Math.round;
var _Basics_sqrt = Math.sqrt;
var _Basics_log = Math.log;
var _Basics_isNaN = isNaN;


// BOOLEANS

function _Basics_not(bool) { return !bool; }
var _Basics_and = F2(function(a, b) { return a && b; });
var _Basics_or  = F2(function(a, b) { return a || b; });
var _Basics_xor = F2(function(a, b) { return a !== b; });



var _String_cons = F2(function(chr, str)
{
	return chr + str;
});

function _String_uncons(string)
{
	var word = string.charCodeAt(0);
	return !isNaN(word)
		? $elm$core$Maybe$Just(
			0xD800 <= word && word <= 0xDBFF
				? _Utils_Tuple2(_Utils_chr(string[0] + string[1]), string.slice(2))
				: _Utils_Tuple2(_Utils_chr(string[0]), string.slice(1))
		)
		: $elm$core$Maybe$Nothing;
}

var _String_append = F2(function(a, b)
{
	return a + b;
});

function _String_length(str)
{
	return str.length;
}

var _String_map = F2(function(func, string)
{
	var len = string.length;
	var array = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = string.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			array[i] = func(_Utils_chr(string[i] + string[i+1]));
			i += 2;
			continue;
		}
		array[i] = func(_Utils_chr(string[i]));
		i++;
	}
	return array.join('');
});

var _String_filter = F2(function(isGood, str)
{
	var arr = [];
	var len = str.length;
	var i = 0;
	while (i < len)
	{
		var char = str[i];
		var word = str.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += str[i];
			i++;
		}

		if (isGood(_Utils_chr(char)))
		{
			arr.push(char);
		}
	}
	return arr.join('');
});

function _String_reverse(str)
{
	var len = str.length;
	var arr = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = str.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			arr[len - i] = str[i + 1];
			i++;
			arr[len - i] = str[i - 1];
			i++;
		}
		else
		{
			arr[len - i] = str[i];
			i++;
		}
	}
	return arr.join('');
}

var _String_foldl = F3(function(func, state, string)
{
	var len = string.length;
	var i = 0;
	while (i < len)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += string[i];
			i++;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_foldr = F3(function(func, state, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_split = F2(function(sep, str)
{
	return str.split(sep);
});

var _String_join = F2(function(sep, strs)
{
	return strs.join(sep);
});

var _String_slice = F3(function(start, end, str) {
	return str.slice(start, end);
});

function _String_trim(str)
{
	return str.trim();
}

function _String_trimLeft(str)
{
	return str.replace(/^\s+/, '');
}

function _String_trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function _String_words(str)
{
	return _List_fromArray(str.trim().split(/\s+/g));
}

function _String_lines(str)
{
	return _List_fromArray(str.split(/\r\n|\r|\n/g));
}

function _String_toUpper(str)
{
	return str.toUpperCase();
}

function _String_toLower(str)
{
	return str.toLowerCase();
}

var _String_any = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (isGood(_Utils_chr(char)))
		{
			return true;
		}
	}
	return false;
});

var _String_all = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (!isGood(_Utils_chr(char)))
		{
			return false;
		}
	}
	return true;
});

var _String_contains = F2(function(sub, str)
{
	return str.indexOf(sub) > -1;
});

var _String_startsWith = F2(function(sub, str)
{
	return str.indexOf(sub) === 0;
});

var _String_endsWith = F2(function(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
});

var _String_indexes = F2(function(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _List_Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _List_fromArray(is);
});


// TO STRING

function _String_fromNumber(number)
{
	return number + '';
}


// INT CONVERSIONS

function _String_toInt(str)
{
	var total = 0;
	var code0 = str.charCodeAt(0);
	var start = code0 == 0x2B /* + */ || code0 == 0x2D /* - */ ? 1 : 0;

	for (var i = start; i < str.length; ++i)
	{
		var code = str.charCodeAt(i);
		if (code < 0x30 || 0x39 < code)
		{
			return $elm$core$Maybe$Nothing;
		}
		total = 10 * total + code - 0x30;
	}

	return i == start
		? $elm$core$Maybe$Nothing
		: $elm$core$Maybe$Just(code0 == 0x2D ? -total : total);
}


// FLOAT CONVERSIONS

function _String_toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return $elm$core$Maybe$Nothing;
	}
	var n = +s;
	// faster isNaN check
	return n === n ? $elm$core$Maybe$Just(n) : $elm$core$Maybe$Nothing;
}

function _String_fromList(chars)
{
	return _List_toArray(chars).join('');
}




function _Char_toCode(char)
{
	var code = char.charCodeAt(0);
	if (0xD800 <= code && code <= 0xDBFF)
	{
		return (code - 0xD800) * 0x400 + char.charCodeAt(1) - 0xDC00 + 0x10000
	}
	return code;
}

function _Char_fromCode(code)
{
	return _Utils_chr(
		(code < 0 || 0x10FFFF < code)
			? '\uFFFD'
			:
		(code <= 0xFFFF)
			? String.fromCharCode(code)
			:
		(code -= 0x10000,
			String.fromCharCode(Math.floor(code / 0x400) + 0xD800, code % 0x400 + 0xDC00)
		)
	);
}

function _Char_toUpper(char)
{
	return _Utils_chr(char.toUpperCase());
}

function _Char_toLower(char)
{
	return _Utils_chr(char.toLowerCase());
}

function _Char_toLocaleUpper(char)
{
	return _Utils_chr(char.toLocaleUpperCase());
}

function _Char_toLocaleLower(char)
{
	return _Utils_chr(char.toLocaleLowerCase());
}



/**/
function _Json_errorToString(error)
{
	return $elm$json$Json$Decode$errorToString(error);
}
//*/


// CORE DECODERS

function _Json_succeed(msg)
{
	return {
		$: 0,
		a: msg
	};
}

function _Json_fail(msg)
{
	return {
		$: 1,
		a: msg
	};
}

function _Json_decodePrim(decoder)
{
	return { $: 2, b: decoder };
}

var _Json_decodeInt = _Json_decodePrim(function(value) {
	return (typeof value !== 'number')
		? _Json_expecting('an INT', value)
		:
	(-2147483647 < value && value < 2147483647 && (value | 0) === value)
		? $elm$core$Result$Ok(value)
		:
	(isFinite(value) && !(value % 1))
		? $elm$core$Result$Ok(value)
		: _Json_expecting('an INT', value);
});

var _Json_decodeBool = _Json_decodePrim(function(value) {
	return (typeof value === 'boolean')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a BOOL', value);
});

var _Json_decodeFloat = _Json_decodePrim(function(value) {
	return (typeof value === 'number')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a FLOAT', value);
});

var _Json_decodeValue = _Json_decodePrim(function(value) {
	return $elm$core$Result$Ok(_Json_wrap(value));
});

var _Json_decodeString = _Json_decodePrim(function(value) {
	return (typeof value === 'string')
		? $elm$core$Result$Ok(value)
		: (value instanceof String)
			? $elm$core$Result$Ok(value + '')
			: _Json_expecting('a STRING', value);
});

function _Json_decodeList(decoder) { return { $: 3, b: decoder }; }
function _Json_decodeArray(decoder) { return { $: 4, b: decoder }; }

function _Json_decodeNull(value) { return { $: 5, c: value }; }

var _Json_decodeField = F2(function(field, decoder)
{
	return {
		$: 6,
		d: field,
		b: decoder
	};
});

var _Json_decodeIndex = F2(function(index, decoder)
{
	return {
		$: 7,
		e: index,
		b: decoder
	};
});

function _Json_decodeKeyValuePairs(decoder)
{
	return {
		$: 8,
		b: decoder
	};
}

function _Json_mapMany(f, decoders)
{
	return {
		$: 9,
		f: f,
		g: decoders
	};
}

var _Json_andThen = F2(function(callback, decoder)
{
	return {
		$: 10,
		b: decoder,
		h: callback
	};
});

function _Json_oneOf(decoders)
{
	return {
		$: 11,
		g: decoders
	};
}


// DECODING OBJECTS

var _Json_map1 = F2(function(f, d1)
{
	return _Json_mapMany(f, [d1]);
});

var _Json_map2 = F3(function(f, d1, d2)
{
	return _Json_mapMany(f, [d1, d2]);
});

var _Json_map3 = F4(function(f, d1, d2, d3)
{
	return _Json_mapMany(f, [d1, d2, d3]);
});

var _Json_map4 = F5(function(f, d1, d2, d3, d4)
{
	return _Json_mapMany(f, [d1, d2, d3, d4]);
});

var _Json_map5 = F6(function(f, d1, d2, d3, d4, d5)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5]);
});

var _Json_map6 = F7(function(f, d1, d2, d3, d4, d5, d6)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6]);
});

var _Json_map7 = F8(function(f, d1, d2, d3, d4, d5, d6, d7)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
});

var _Json_map8 = F9(function(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
});


// DECODE

var _Json_runOnString = F2(function(decoder, string)
{
	try
	{
		var value = JSON.parse(string);
		return _Json_runHelp(decoder, value);
	}
	catch (e)
	{
		return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'This is not valid JSON! ' + e.message, _Json_wrap(string)));
	}
});

var _Json_run = F2(function(decoder, value)
{
	return _Json_runHelp(decoder, _Json_unwrap(value));
});

function _Json_runHelp(decoder, value)
{
	switch (decoder.$)
	{
		case 2:
			return decoder.b(value);

		case 5:
			return (value === null)
				? $elm$core$Result$Ok(decoder.c)
				: _Json_expecting('null', value);

		case 3:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('a LIST', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _List_fromArray);

		case 4:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _Json_toElmArray);

		case 6:
			var field = decoder.d;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return _Json_expecting('an OBJECT with a field named `' + field + '`', value);
			}
			var result = _Json_runHelp(decoder.b, value[field]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, field, result.a));

		case 7:
			var index = decoder.e;
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			if (index >= value.length)
			{
				return _Json_expecting('a LONGER array. Need index ' + index + ' but only see ' + value.length + ' entries', value);
			}
			var result = _Json_runHelp(decoder.b, value[index]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, index, result.a));

		case 8:
			if (typeof value !== 'object' || value === null || _Json_isArray(value))
			{
				return _Json_expecting('an OBJECT', value);
			}

			var keyValuePairs = _List_Nil;
			// TODO test perf of Object.keys and switch when support is good enough
			for (var key in value)
			{
				if (value.hasOwnProperty(key))
				{
					var result = _Json_runHelp(decoder.b, value[key]);
					if (!$elm$core$Result$isOk(result))
					{
						return $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, key, result.a));
					}
					keyValuePairs = _List_Cons(_Utils_Tuple2(key, result.a), keyValuePairs);
				}
			}
			return $elm$core$Result$Ok($elm$core$List$reverse(keyValuePairs));

		case 9:
			var answer = decoder.f;
			var decoders = decoder.g;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = _Json_runHelp(decoders[i], value);
				if (!$elm$core$Result$isOk(result))
				{
					return result;
				}
				answer = answer(result.a);
			}
			return $elm$core$Result$Ok(answer);

		case 10:
			var result = _Json_runHelp(decoder.b, value);
			return (!$elm$core$Result$isOk(result))
				? result
				: _Json_runHelp(decoder.h(result.a), value);

		case 11:
			var errors = _List_Nil;
			for (var temp = decoder.g; temp.b; temp = temp.b) // WHILE_CONS
			{
				var result = _Json_runHelp(temp.a, value);
				if ($elm$core$Result$isOk(result))
				{
					return result;
				}
				errors = _List_Cons(result.a, errors);
			}
			return $elm$core$Result$Err($elm$json$Json$Decode$OneOf($elm$core$List$reverse(errors)));

		case 1:
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, decoder.a, _Json_wrap(value)));

		case 0:
			return $elm$core$Result$Ok(decoder.a);
	}
}

function _Json_runArrayDecoder(decoder, value, toElmValue)
{
	var len = value.length;
	var array = new Array(len);
	for (var i = 0; i < len; i++)
	{
		var result = _Json_runHelp(decoder, value[i]);
		if (!$elm$core$Result$isOk(result))
		{
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, i, result.a));
		}
		array[i] = result.a;
	}
	return $elm$core$Result$Ok(toElmValue(array));
}

function _Json_isArray(value)
{
	return Array.isArray(value) || (typeof FileList !== 'undefined' && value instanceof FileList);
}

function _Json_toElmArray(array)
{
	return A2($elm$core$Array$initialize, array.length, function(i) { return array[i]; });
}

function _Json_expecting(type, value)
{
	return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'Expecting ' + type, _Json_wrap(value)));
}


// EQUALITY

function _Json_equality(x, y)
{
	if (x === y)
	{
		return true;
	}

	if (x.$ !== y.$)
	{
		return false;
	}

	switch (x.$)
	{
		case 0:
		case 1:
			return x.a === y.a;

		case 2:
			return x.b === y.b;

		case 5:
			return x.c === y.c;

		case 3:
		case 4:
		case 8:
			return _Json_equality(x.b, y.b);

		case 6:
			return x.d === y.d && _Json_equality(x.b, y.b);

		case 7:
			return x.e === y.e && _Json_equality(x.b, y.b);

		case 9:
			return x.f === y.f && _Json_listEquality(x.g, y.g);

		case 10:
			return x.h === y.h && _Json_equality(x.b, y.b);

		case 11:
			return _Json_listEquality(x.g, y.g);
	}
}

function _Json_listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!_Json_equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

var _Json_encode = F2(function(indentLevel, value)
{
	return JSON.stringify(_Json_unwrap(value), null, indentLevel) + '';
});

function _Json_wrap(value) { return { $: 0, a: value }; }
function _Json_unwrap(value) { return value.a; }

function _Json_wrap_UNUSED(value) { return value; }
function _Json_unwrap_UNUSED(value) { return value; }

function _Json_emptyArray() { return []; }
function _Json_emptyObject() { return {}; }

var _Json_addField = F3(function(key, value, object)
{
	object[key] = _Json_unwrap(value);
	return object;
});

function _Json_addEntry(func)
{
	return F2(function(entry, array)
	{
		array.push(_Json_unwrap(func(entry)));
		return array;
	});
}

var _Json_encodeNull = _Json_wrap(null);



// TASKS

function _Scheduler_succeed(value)
{
	return {
		$: 0,
		a: value
	};
}

function _Scheduler_fail(error)
{
	return {
		$: 1,
		a: error
	};
}

function _Scheduler_binding(callback)
{
	return {
		$: 2,
		b: callback,
		c: null
	};
}

var _Scheduler_andThen = F2(function(callback, task)
{
	return {
		$: 3,
		b: callback,
		d: task
	};
});

var _Scheduler_onError = F2(function(callback, task)
{
	return {
		$: 4,
		b: callback,
		d: task
	};
});

function _Scheduler_receive(callback)
{
	return {
		$: 5,
		b: callback
	};
}


// PROCESSES

var _Scheduler_guid = 0;

function _Scheduler_rawSpawn(task)
{
	var proc = {
		$: 0,
		e: _Scheduler_guid++,
		f: task,
		g: null,
		h: []
	};

	_Scheduler_enqueue(proc);

	return proc;
}

function _Scheduler_spawn(task)
{
	return _Scheduler_binding(function(callback) {
		callback(_Scheduler_succeed(_Scheduler_rawSpawn(task)));
	});
}

function _Scheduler_rawSend(proc, msg)
{
	proc.h.push(msg);
	_Scheduler_enqueue(proc);
}

var _Scheduler_send = F2(function(proc, msg)
{
	return _Scheduler_binding(function(callback) {
		_Scheduler_rawSend(proc, msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});

function _Scheduler_kill(proc)
{
	return _Scheduler_binding(function(callback) {
		var task = proc.f;
		if (task.$ === 2 && task.c)
		{
			task.c();
		}

		proc.f = null;

		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


/* STEP PROCESSES

type alias Process =
  { $ : tag
  , id : unique_id
  , root : Task
  , stack : null | { $: SUCCEED | FAIL, a: callback, b: stack }
  , mailbox : [msg]
  }

*/


var _Scheduler_working = false;
var _Scheduler_queue = [];


function _Scheduler_enqueue(proc)
{
	_Scheduler_queue.push(proc);
	if (_Scheduler_working)
	{
		return;
	}
	_Scheduler_working = true;
	while (proc = _Scheduler_queue.shift())
	{
		_Scheduler_step(proc);
	}
	_Scheduler_working = false;
}


function _Scheduler_step(proc)
{
	while (proc.f)
	{
		var rootTag = proc.f.$;
		if (rootTag === 0 || rootTag === 1)
		{
			while (proc.g && proc.g.$ !== rootTag)
			{
				proc.g = proc.g.i;
			}
			if (!proc.g)
			{
				return;
			}
			proc.f = proc.g.b(proc.f.a);
			proc.g = proc.g.i;
		}
		else if (rootTag === 2)
		{
			proc.f.c = proc.f.b(function(newRoot) {
				proc.f = newRoot;
				_Scheduler_enqueue(proc);
			});
			return;
		}
		else if (rootTag === 5)
		{
			if (proc.h.length === 0)
			{
				return;
			}
			proc.f = proc.f.b(proc.h.shift());
		}
		else // if (rootTag === 3 || rootTag === 4)
		{
			proc.g = {
				$: rootTag === 3 ? 0 : 1,
				b: proc.f.b,
				i: proc.g
			};
			proc.f = proc.f.d;
		}
	}
}



function _Process_sleep(time)
{
	return _Scheduler_binding(function(callback) {
		var id = setTimeout(function() {
			callback(_Scheduler_succeed(_Utils_Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}




// PROGRAMS


var _Platform_worker = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	$elm$core$Result$isOk(result) || _Debug_crash(2 /**/, _Json_errorToString(result.a) /**/);
	var managers = {};
	var initPair = init(result.a);
	var model = initPair.a;
	var stepper = stepperBuilder(sendToApp, model);
	var ports = _Platform_setupEffects(managers, sendToApp);

	function sendToApp(msg, viewMetadata)
	{
		var pair = A2(update, msg, model);
		stepper(model = pair.a, viewMetadata);
		_Platform_enqueueEffects(managers, pair.b, subscriptions(model));
	}

	_Platform_enqueueEffects(managers, initPair.b, subscriptions(model));

	return ports ? { ports: ports } : {};
}



// TRACK PRELOADS
//
// This is used by code in elm/browser and elm/http
// to register any HTTP requests that are triggered by init.
//


var _Platform_preload;


function _Platform_registerPreload(url)
{
	_Platform_preload.add(url);
}



// EFFECT MANAGERS


var _Platform_effectManagers = {};


function _Platform_setupEffects(managers, sendToApp)
{
	var ports;

	// setup all necessary effect managers
	for (var key in _Platform_effectManagers)
	{
		var manager = _Platform_effectManagers[key];

		if (manager.a)
		{
			ports = ports || {};
			ports[key] = manager.a(key, sendToApp);
		}

		managers[key] = _Platform_instantiateManager(manager, sendToApp);
	}

	return ports;
}


function _Platform_createManager(init, onEffects, onSelfMsg, cmdMap, subMap)
{
	return {
		b: init,
		c: onEffects,
		d: onSelfMsg,
		e: cmdMap,
		f: subMap
	};
}


function _Platform_instantiateManager(info, sendToApp)
{
	var router = {
		g: sendToApp,
		h: undefined
	};

	var onEffects = info.c;
	var onSelfMsg = info.d;
	var cmdMap = info.e;
	var subMap = info.f;

	function loop(state)
	{
		return A2(_Scheduler_andThen, loop, _Scheduler_receive(function(msg)
		{
			var value = msg.a;

			if (msg.$ === 0)
			{
				return A3(onSelfMsg, router, value, state);
			}

			return cmdMap && subMap
				? A4(onEffects, router, value.i, value.j, state)
				: A3(onEffects, router, cmdMap ? value.i : value.j, state);
		}));
	}

	return router.h = _Scheduler_rawSpawn(A2(_Scheduler_andThen, loop, info.b));
}



// ROUTING


var _Platform_sendToApp = F2(function(router, msg)
{
	return _Scheduler_binding(function(callback)
	{
		router.g(msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});


var _Platform_sendToSelf = F2(function(router, msg)
{
	return A2(_Scheduler_send, router.h, {
		$: 0,
		a: msg
	});
});



// BAGS


function _Platform_leaf(home)
{
	return function(value)
	{
		return {
			$: 1,
			k: home,
			l: value
		};
	};
}


function _Platform_batch(list)
{
	return {
		$: 2,
		m: list
	};
}


var _Platform_map = F2(function(tagger, bag)
{
	return {
		$: 3,
		n: tagger,
		o: bag
	}
});



// PIPE BAGS INTO EFFECT MANAGERS
//
// Effects must be queued!
//
// Say your init contains a synchronous command, like Time.now or Time.here
//
//   - This will produce a batch of effects (FX_1)
//   - The synchronous task triggers the subsequent `update` call
//   - This will produce a batch of effects (FX_2)
//
// If we just start dispatching FX_2, subscriptions from FX_2 can be processed
// before subscriptions from FX_1. No good! Earlier versions of this code had
// this problem, leading to these reports:
//
//   https://github.com/elm/core/issues/980
//   https://github.com/elm/core/pull/981
//   https://github.com/elm/compiler/issues/1776
//
// The queue is necessary to avoid ordering issues for synchronous commands.


// Why use true/false here? Why not just check the length of the queue?
// The goal is to detect "are we currently dispatching effects?" If we
// are, we need to bail and let the ongoing while loop handle things.
//
// Now say the queue has 1 element. When we dequeue the final element,
// the queue will be empty, but we are still actively dispatching effects.
// So you could get queue jumping in a really tricky category of cases.
//
var _Platform_effectsQueue = [];
var _Platform_effectsActive = false;


function _Platform_enqueueEffects(managers, cmdBag, subBag)
{
	_Platform_effectsQueue.push({ p: managers, q: cmdBag, r: subBag });

	if (_Platform_effectsActive) return;

	_Platform_effectsActive = true;
	for (var fx; fx = _Platform_effectsQueue.shift(); )
	{
		_Platform_dispatchEffects(fx.p, fx.q, fx.r);
	}
	_Platform_effectsActive = false;
}


function _Platform_dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	_Platform_gatherEffects(true, cmdBag, effectsDict, null);
	_Platform_gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		_Scheduler_rawSend(managers[home], {
			$: 'fx',
			a: effectsDict[home] || { i: _List_Nil, j: _List_Nil }
		});
	}
}


function _Platform_gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.$)
	{
		case 1:
			var home = bag.k;
			var effect = _Platform_toEffect(isCmd, home, taggers, bag.l);
			effectsDict[home] = _Platform_insert(isCmd, effect, effectsDict[home]);
			return;

		case 2:
			for (var list = bag.m; list.b; list = list.b) // WHILE_CONS
			{
				_Platform_gatherEffects(isCmd, list.a, effectsDict, taggers);
			}
			return;

		case 3:
			_Platform_gatherEffects(isCmd, bag.o, effectsDict, {
				s: bag.n,
				t: taggers
			});
			return;
	}
}


function _Platform_toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		for (var temp = taggers; temp; temp = temp.t)
		{
			x = temp.s(x);
		}
		return x;
	}

	var map = isCmd
		? _Platform_effectManagers[home].e
		: _Platform_effectManagers[home].f;

	return A2(map, applyTaggers, value)
}


function _Platform_insert(isCmd, newEffect, effects)
{
	effects = effects || { i: _List_Nil, j: _List_Nil };

	isCmd
		? (effects.i = _List_Cons(newEffect, effects.i))
		: (effects.j = _List_Cons(newEffect, effects.j));

	return effects;
}



// PORTS


function _Platform_checkPortName(name)
{
	if (_Platform_effectManagers[name])
	{
		_Debug_crash(3, name)
	}
}



// OUTGOING PORTS


function _Platform_outgoingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		e: _Platform_outgoingPortMap,
		u: converter,
		a: _Platform_setupOutgoingPort
	};
	return _Platform_leaf(name);
}


var _Platform_outgoingPortMap = F2(function(tagger, value) { return value; });


function _Platform_setupOutgoingPort(name)
{
	var subs = [];
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Process_sleep(0);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, cmdList, state)
	{
		for ( ; cmdList.b; cmdList = cmdList.b) // WHILE_CONS
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = _Json_unwrap(converter(cmdList.a));
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
		}
		return init;
	});

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}



// INCOMING PORTS


function _Platform_incomingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		f: _Platform_incomingPortMap,
		u: converter,
		a: _Platform_setupIncomingPort
	};
	return _Platform_leaf(name);
}


var _Platform_incomingPortMap = F2(function(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});


function _Platform_setupIncomingPort(name, sendToApp)
{
	var subs = _List_Nil;
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Scheduler_succeed(null);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, subList, state)
	{
		subs = subList;
		return init;
	});

	// PUBLIC API

	function send(incomingValue)
	{
		var result = A2(_Json_run, converter, _Json_wrap(incomingValue));

		$elm$core$Result$isOk(result) || _Debug_crash(4, name, result.a);

		var value = result.a;
		for (var temp = subs; temp.b; temp = temp.b) // WHILE_CONS
		{
			sendToApp(temp.a(value));
		}
	}

	return { send: send };
}



// EXPORT ELM MODULES
//
// Have DEBUG and PROD versions so that we can (1) give nicer errors in
// debug mode and (2) not pay for the bits needed for that in prod mode.
//


function _Platform_export_UNUSED(exports)
{
	scope['Elm']
		? _Platform_mergeExportsProd(scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsProd(obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6)
				: _Platform_mergeExportsProd(obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}


function _Platform_export(exports)
{
	scope['Elm']
		? _Platform_mergeExportsDebug('Elm', scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsDebug(moduleName, obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6, moduleName)
				: _Platform_mergeExportsDebug(moduleName + '.' + name, obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}
var $elm$core$Basics$EQ = {$: 'EQ'};
var $elm$core$Basics$LT = {$: 'LT'};
var $elm$core$List$cons = _List_cons;
var $elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var $elm$core$Array$foldr = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
					var subTree = node.a;
					return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3($elm$core$Elm$JsArray$foldr, func, acc, values);
				}
			});
		return A3(
			$elm$core$Elm$JsArray$foldr,
			helper,
			A3($elm$core$Elm$JsArray$foldr, func, baseCase, tail),
			tree);
	});
var $elm$core$Array$toList = function (array) {
	return A3($elm$core$Array$foldr, $elm$core$List$cons, _List_Nil, array);
};
var $elm$core$Dict$foldr = F3(
	function (func, acc, t) {
		foldr:
		while (true) {
			if (t.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = t.b;
				var value = t.c;
				var left = t.d;
				var right = t.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldr, func, acc, right)),
					$temp$t = left;
				func = $temp$func;
				acc = $temp$acc;
				t = $temp$t;
				continue foldr;
			}
		}
	});
var $elm$core$Dict$toList = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					$elm$core$List$cons,
					_Utils_Tuple2(key, value),
					list);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Dict$keys = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2($elm$core$List$cons, key, keyList);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Set$toList = function (_v0) {
	var dict = _v0.a;
	return $elm$core$Dict$keys(dict);
};
var $elm$core$Basics$GT = {$: 'GT'};
var $elm$core$Result$Err = function (a) {
	return {$: 'Err', a: a};
};
var $elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 'Failure', a: a, b: b};
	});
var $elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var $elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 'Index', a: a, b: b};
	});
var $elm$core$Result$Ok = function (a) {
	return {$: 'Ok', a: a};
};
var $elm$json$Json$Decode$OneOf = function (a) {
	return {$: 'OneOf', a: a};
};
var $elm$core$Basics$False = {$: 'False'};
var $elm$core$Basics$add = _Basics_add;
var $elm$core$Maybe$Just = function (a) {
	return {$: 'Just', a: a};
};
var $elm$core$Maybe$Nothing = {$: 'Nothing'};
var $elm$core$String$all = _String_all;
var $elm$core$Basics$and = _Basics_and;
var $elm$core$Basics$append = _Utils_append;
var $elm$json$Json$Encode$encode = _Json_encode;
var $elm$core$String$fromInt = _String_fromNumber;
var $elm$core$String$join = F2(
	function (sep, chunks) {
		return A2(
			_String_join,
			sep,
			_List_toArray(chunks));
	});
var $elm$core$String$split = F2(
	function (sep, string) {
		return _List_fromArray(
			A2(_String_split, sep, string));
	});
var $elm$json$Json$Decode$indent = function (str) {
	return A2(
		$elm$core$String$join,
		'\n    ',
		A2($elm$core$String$split, '\n', str));
};
var $elm$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			if (!list.b) {
				return acc;
			} else {
				var x = list.a;
				var xs = list.b;
				var $temp$func = func,
					$temp$acc = A2(func, x, acc),
					$temp$list = xs;
				func = $temp$func;
				acc = $temp$acc;
				list = $temp$list;
				continue foldl;
			}
		}
	});
var $elm$core$List$length = function (xs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, i) {
				return i + 1;
			}),
		0,
		xs);
};
var $elm$core$List$map2 = _List_map2;
var $elm$core$Basics$le = _Utils_le;
var $elm$core$Basics$sub = _Basics_sub;
var $elm$core$List$rangeHelp = F3(
	function (lo, hi, list) {
		rangeHelp:
		while (true) {
			if (_Utils_cmp(lo, hi) < 1) {
				var $temp$lo = lo,
					$temp$hi = hi - 1,
					$temp$list = A2($elm$core$List$cons, hi, list);
				lo = $temp$lo;
				hi = $temp$hi;
				list = $temp$list;
				continue rangeHelp;
			} else {
				return list;
			}
		}
	});
var $elm$core$List$range = F2(
	function (lo, hi) {
		return A3($elm$core$List$rangeHelp, lo, hi, _List_Nil);
	});
var $elm$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$map2,
			f,
			A2(
				$elm$core$List$range,
				0,
				$elm$core$List$length(xs) - 1),
			xs);
	});
var $elm$core$Char$toCode = _Char_toCode;
var $elm$core$Char$isLower = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (97 <= code) && (code <= 122);
};
var $elm$core$Char$isUpper = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 90) && (65 <= code);
};
var $elm$core$Basics$or = _Basics_or;
var $elm$core$Char$isAlpha = function (_char) {
	return $elm$core$Char$isLower(_char) || $elm$core$Char$isUpper(_char);
};
var $elm$core$Char$isDigit = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 57) && (48 <= code);
};
var $elm$core$Char$isAlphaNum = function (_char) {
	return $elm$core$Char$isLower(_char) || ($elm$core$Char$isUpper(_char) || $elm$core$Char$isDigit(_char));
};
var $elm$core$List$reverse = function (list) {
	return A3($elm$core$List$foldl, $elm$core$List$cons, _List_Nil, list);
};
var $elm$core$String$uncons = _String_uncons;
var $elm$json$Json$Decode$errorOneOf = F2(
	function (i, error) {
		return '\n\n(' + ($elm$core$String$fromInt(i + 1) + (') ' + $elm$json$Json$Decode$indent(
			$elm$json$Json$Decode$errorToString(error))));
	});
var $elm$json$Json$Decode$errorToString = function (error) {
	return A2($elm$json$Json$Decode$errorToStringHelp, error, _List_Nil);
};
var $elm$json$Json$Decode$errorToStringHelp = F2(
	function (error, context) {
		errorToStringHelp:
		while (true) {
			switch (error.$) {
				case 'Field':
					var f = error.a;
					var err = error.b;
					var isSimple = function () {
						var _v1 = $elm$core$String$uncons(f);
						if (_v1.$ === 'Nothing') {
							return false;
						} else {
							var _v2 = _v1.a;
							var _char = _v2.a;
							var rest = _v2.b;
							return $elm$core$Char$isAlpha(_char) && A2($elm$core$String$all, $elm$core$Char$isAlphaNum, rest);
						}
					}();
					var fieldName = isSimple ? ('.' + f) : ('[\'' + (f + '\']'));
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, fieldName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'Index':
					var i = error.a;
					var err = error.b;
					var indexName = '[' + ($elm$core$String$fromInt(i) + ']');
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, indexName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'OneOf':
					var errors = error.a;
					if (!errors.b) {
						return 'Ran into a Json.Decode.oneOf with no possibilities' + function () {
							if (!context.b) {
								return '!';
							} else {
								return ' at json' + A2(
									$elm$core$String$join,
									'',
									$elm$core$List$reverse(context));
							}
						}();
					} else {
						if (!errors.b.b) {
							var err = errors.a;
							var $temp$error = err,
								$temp$context = context;
							error = $temp$error;
							context = $temp$context;
							continue errorToStringHelp;
						} else {
							var starter = function () {
								if (!context.b) {
									return 'Json.Decode.oneOf';
								} else {
									return 'The Json.Decode.oneOf at json' + A2(
										$elm$core$String$join,
										'',
										$elm$core$List$reverse(context));
								}
							}();
							var introduction = starter + (' failed in the following ' + ($elm$core$String$fromInt(
								$elm$core$List$length(errors)) + ' ways:'));
							return A2(
								$elm$core$String$join,
								'\n\n',
								A2(
									$elm$core$List$cons,
									introduction,
									A2($elm$core$List$indexedMap, $elm$json$Json$Decode$errorOneOf, errors)));
						}
					}
				default:
					var msg = error.a;
					var json = error.b;
					var introduction = function () {
						if (!context.b) {
							return 'Problem with the given value:\n\n';
						} else {
							return 'Problem with the value at json' + (A2(
								$elm$core$String$join,
								'',
								$elm$core$List$reverse(context)) + ':\n\n    ');
						}
					}();
					return introduction + ($elm$json$Json$Decode$indent(
						A2($elm$json$Json$Encode$encode, 4, json)) + ('\n\n' + msg));
			}
		}
	});
var $elm$core$Array$branchFactor = 32;
var $elm$core$Array$Array_elm_builtin = F4(
	function (a, b, c, d) {
		return {$: 'Array_elm_builtin', a: a, b: b, c: c, d: d};
	});
var $elm$core$Elm$JsArray$empty = _JsArray_empty;
var $elm$core$Basics$ceiling = _Basics_ceiling;
var $elm$core$Basics$fdiv = _Basics_fdiv;
var $elm$core$Basics$logBase = F2(
	function (base, number) {
		return _Basics_log(number) / _Basics_log(base);
	});
var $elm$core$Basics$toFloat = _Basics_toFloat;
var $elm$core$Array$shiftStep = $elm$core$Basics$ceiling(
	A2($elm$core$Basics$logBase, 2, $elm$core$Array$branchFactor));
var $elm$core$Array$empty = A4($elm$core$Array$Array_elm_builtin, 0, $elm$core$Array$shiftStep, $elm$core$Elm$JsArray$empty, $elm$core$Elm$JsArray$empty);
var $elm$core$Elm$JsArray$initialize = _JsArray_initialize;
var $elm$core$Array$Leaf = function (a) {
	return {$: 'Leaf', a: a};
};
var $elm$core$Basics$apL = F2(
	function (f, x) {
		return f(x);
	});
var $elm$core$Basics$apR = F2(
	function (x, f) {
		return f(x);
	});
var $elm$core$Basics$eq = _Utils_equal;
var $elm$core$Basics$floor = _Basics_floor;
var $elm$core$Elm$JsArray$length = _JsArray_length;
var $elm$core$Basics$gt = _Utils_gt;
var $elm$core$Basics$max = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) > 0) ? x : y;
	});
var $elm$core$Basics$mul = _Basics_mul;
var $elm$core$Array$SubTree = function (a) {
	return {$: 'SubTree', a: a};
};
var $elm$core$Elm$JsArray$initializeFromList = _JsArray_initializeFromList;
var $elm$core$Array$compressNodes = F2(
	function (nodes, acc) {
		compressNodes:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodes);
			var node = _v0.a;
			var remainingNodes = _v0.b;
			var newAcc = A2(
				$elm$core$List$cons,
				$elm$core$Array$SubTree(node),
				acc);
			if (!remainingNodes.b) {
				return $elm$core$List$reverse(newAcc);
			} else {
				var $temp$nodes = remainingNodes,
					$temp$acc = newAcc;
				nodes = $temp$nodes;
				acc = $temp$acc;
				continue compressNodes;
			}
		}
	});
var $elm$core$Tuple$first = function (_v0) {
	var x = _v0.a;
	return x;
};
var $elm$core$Array$treeFromBuilder = F2(
	function (nodeList, nodeListSize) {
		treeFromBuilder:
		while (true) {
			var newNodeSize = $elm$core$Basics$ceiling(nodeListSize / $elm$core$Array$branchFactor);
			if (newNodeSize === 1) {
				return A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodeList).a;
			} else {
				var $temp$nodeList = A2($elm$core$Array$compressNodes, nodeList, _List_Nil),
					$temp$nodeListSize = newNodeSize;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue treeFromBuilder;
			}
		}
	});
var $elm$core$Array$builderToArray = F2(
	function (reverseNodeList, builder) {
		if (!builder.nodeListSize) {
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail),
				$elm$core$Array$shiftStep,
				$elm$core$Elm$JsArray$empty,
				builder.tail);
		} else {
			var treeLen = builder.nodeListSize * $elm$core$Array$branchFactor;
			var depth = $elm$core$Basics$floor(
				A2($elm$core$Basics$logBase, $elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? $elm$core$List$reverse(builder.nodeList) : builder.nodeList;
			var tree = A2($elm$core$Array$treeFromBuilder, correctNodeList, builder.nodeListSize);
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail) + treeLen,
				A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep),
				tree,
				builder.tail);
		}
	});
var $elm$core$Basics$idiv = _Basics_idiv;
var $elm$core$Basics$lt = _Utils_lt;
var $elm$core$Array$initializeHelp = F5(
	function (fn, fromIndex, len, nodeList, tail) {
		initializeHelp:
		while (true) {
			if (fromIndex < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					false,
					{nodeList: nodeList, nodeListSize: (len / $elm$core$Array$branchFactor) | 0, tail: tail});
			} else {
				var leaf = $elm$core$Array$Leaf(
					A3($elm$core$Elm$JsArray$initialize, $elm$core$Array$branchFactor, fromIndex, fn));
				var $temp$fn = fn,
					$temp$fromIndex = fromIndex - $elm$core$Array$branchFactor,
					$temp$len = len,
					$temp$nodeList = A2($elm$core$List$cons, leaf, nodeList),
					$temp$tail = tail;
				fn = $temp$fn;
				fromIndex = $temp$fromIndex;
				len = $temp$len;
				nodeList = $temp$nodeList;
				tail = $temp$tail;
				continue initializeHelp;
			}
		}
	});
var $elm$core$Basics$remainderBy = _Basics_remainderBy;
var $elm$core$Array$initialize = F2(
	function (len, fn) {
		if (len <= 0) {
			return $elm$core$Array$empty;
		} else {
			var tailLen = len % $elm$core$Array$branchFactor;
			var tail = A3($elm$core$Elm$JsArray$initialize, tailLen, len - tailLen, fn);
			var initialFromIndex = (len - tailLen) - $elm$core$Array$branchFactor;
			return A5($elm$core$Array$initializeHelp, fn, initialFromIndex, len, _List_Nil, tail);
		}
	});
var $elm$core$Basics$True = {$: 'True'};
var $elm$core$Result$isOk = function (result) {
	if (result.$ === 'Ok') {
		return true;
	} else {
		return false;
	}
};
var $elm$core$Platform$Cmd$batch = _Platform_batch;
var $elm$core$Platform$Cmd$none = $elm$core$Platform$Cmd$batch(_List_Nil);
var $author$project$SvgMaker$init = function (_v0) {
	return _Utils_Tuple2(
		{pos: 0},
		$elm$core$Platform$Cmd$none);
};
var $author$project$SvgMaker$Next = {$: 'Next'};
var $elm$json$Json$Decode$int = _Json_decodeInt;
var $author$project$SvgMaker$nextPage = _Platform_incomingPort('nextPage', $elm$json$Json$Decode$int);
var $author$project$SvgMaker$subscriptions = function (_v0) {
	return $author$project$SvgMaker$nextPage(
		function (_v1) {
			return $author$project$SvgMaker$Next;
		});
};
var $elm$json$Json$Decode$succeed = _Json_succeed;
var $author$project$SvgMaker$Writer = F2(
	function (fname, content) {
		return {content: content, fname: fname};
	});
var $elm$core$List$drop = F2(
	function (n, list) {
		drop:
		while (true) {
			if (n <= 0) {
				return list;
			} else {
				if (!list.b) {
					return list;
				} else {
					var x = list.a;
					var xs = list.b;
					var $temp$n = n - 1,
						$temp$list = xs;
					n = $temp$n;
					list = $temp$list;
					continue drop;
				}
			}
		}
	});
var $author$project$PageSvg$iunit = F2(
	function (n, u) {
		return _Utils_ap(
			$elm$core$String$fromInt(n),
			u);
	});
var $author$project$PageSvg$prop = F2(
	function (name, val) {
		return name + ('=\"' + (val + '\"'));
	});
var $author$project$PageSvg$tag = F3(
	function (name, propl, children) {
		return '<' + (name + (' ' + (A2($elm$core$String$join, ' ', propl) + (' >' + (A2($elm$core$String$join, '\n', children) + ('</' + (name + '>')))))));
	});
var $author$project$PageSvg$pageWrap = F4(
	function (u, w, h, m) {
		return A3(
			$author$project$PageSvg$tag,
			'svg',
			_List_fromArray(
				[
					A2(
					$author$project$PageSvg$prop,
					'width',
					A2($author$project$PageSvg$iunit, w, u)),
					A2(
					$author$project$PageSvg$prop,
					'height',
					A2($author$project$PageSvg$iunit, h, u)),
					A2($author$project$PageSvg$prop, 'xmlns', 'http://www.w3.org/2000/svg'),
					A2(
					$author$project$PageSvg$prop,
					'viewBox',
					'0 0 ' + ($elm$core$String$fromInt(w) + (' ' + $elm$core$String$fromInt(h))))
				]),
			_List_fromArray(
				[m]));
	});
var $author$project$PageSvg$a4Page = A3($author$project$PageSvg$pageWrap, 'mm', 210, 297);
var $author$project$Cards$cTypeColor = function (ct) {
	switch (ct.$) {
		case 'TAttack':
			return 'red';
		case 'TDefence':
			return 'lightgrey';
		case 'TMove':
			return 'lightblue';
		case 'TGold':
			return 'gold';
		case 'TFood':
			return 'lightgreen';
		case 'TWork':
			return 'LightBlue';
		default:
			return 'Blue';
	}
};
var $elm$core$String$fromFloat = _String_fromNumber;
var $author$project$PageSvg$fprop = F2(
	function (name, val) {
		return A2(
			$author$project$PageSvg$prop,
			name,
			$elm$core$String$fromFloat(val));
	});
var $author$project$PageSvg$props = $elm$core$String$join(' ');
var $author$project$PageSvg$flStk = F3(
	function (f, s, w) {
		return $author$project$PageSvg$props(
			_List_fromArray(
				[
					A2($author$project$PageSvg$prop, 'fill', f),
					A2($author$project$PageSvg$prop, 'stroke', s),
					A2($author$project$PageSvg$fprop, 'stroke-width', w)
				]));
	});
var $author$project$PageSvg$flNoStk = function (f) {
	return A3($author$project$PageSvg$flStk, f, 'none', 0);
};
var $author$project$Job$jnum = function (j) {
	if (j.$ === 'N') {
		var n = j.a;
		return $elm$core$String$fromInt(n);
	} else {
		if (j.a === 1) {
			return 'X';
		} else {
			var n = j.a;
			return $elm$core$String$fromInt(n) + 'x';
		}
	}
};
var $author$project$PageSvg$font = F2(
	function (nm, sz) {
		return $author$project$PageSvg$props(
			_List_fromArray(
				[
					A2($author$project$PageSvg$prop, 'font-family', nm),
					A2($author$project$PageSvg$fprop, 'font-size', sz)
				]));
	});
var $author$project$PageSvg$text = F4(
	function (fnt, fsize, pps, txt) {
		return A3(
			$author$project$PageSvg$tag,
			'text',
			A2(
				$elm$core$List$cons,
				A2($author$project$PageSvg$font, fnt, fsize),
				pps),
			_List_fromArray(
				[txt]));
	});
var $author$project$PageSvg$txCenter = A2($author$project$PageSvg$prop, 'text-anchor', 'middle');
var $author$project$PageSvg$xy = F2(
	function (x, y) {
		return $author$project$PageSvg$props(
			_List_fromArray(
				[
					A2($author$project$PageSvg$fprop, 'x', x),
					A2($author$project$PageSvg$fprop, 'y', y)
				]));
	});
var $author$project$CardSvg$jobText = F3(
	function (x, y, str) {
		return A4(
			$author$project$PageSvg$text,
			'Arial',
			4,
			_List_fromArray(
				[
					A2($author$project$PageSvg$xy, x, y),
					$author$project$PageSvg$txCenter,
					$author$project$PageSvg$flNoStk('black')
				]),
			str);
	});
var $author$project$CardSvg$jobTextn = F4(
	function (x, y, tx, n) {
		return A2(
			$elm$core$String$join,
			'\n',
			_List_fromArray(
				[
					A3($author$project$CardSvg$jobText, x + 5, y + 4, tx),
					A3(
					$author$project$CardSvg$jobText,
					x + 5,
					y + 9,
					$author$project$Job$jnum(n))
				]));
	});
var $author$project$PageSvg$etag = F2(
	function (name, propl) {
		return '<' + (name + (' ' + (A2($elm$core$String$join, ' ', propl) + ' />')));
	});
var $author$project$PageSvg$wh = F2(
	function (w, h) {
		return $author$project$PageSvg$props(
			_List_fromArray(
				[
					A2($author$project$PageSvg$fprop, 'width', w),
					A2($author$project$PageSvg$fprop, 'height', h)
				]));
	});
var $author$project$PageSvg$xywh = F4(
	function (x, y, w, h) {
		return $author$project$PageSvg$props(
			_List_fromArray(
				[
					A2($author$project$PageSvg$xy, x, y),
					A2($author$project$PageSvg$wh, w, h)
				]));
	});
var $author$project$PageSvg$rect = F5(
	function (x, y, w, h, pps) {
		return A2(
			$author$project$PageSvg$etag,
			'rect',
			A2(
				$elm$core$List$cons,
				A4($author$project$PageSvg$xywh, x, y, w, h),
				pps));
	});
var $author$project$PageSvg$rotate = F3(
	function (n, x, y) {
		return A2(
			$author$project$PageSvg$prop,
			'transform',
			'rotate(' + ($elm$core$String$fromFloat(n) + (',' + ($elm$core$String$fromFloat(x) + (',' + ($elm$core$String$fromFloat(y) + ')'))))));
	});
var $author$project$PageSvg$rxy = F2(
	function (x, y) {
		return $author$project$PageSvg$props(
			_List_fromArray(
				[
					A2($author$project$PageSvg$fprop, 'rx', x),
					A2($author$project$PageSvg$fprop, 'ry', y)
				]));
	});
var $author$project$CardSvg$jobCard = F5(
	function (x, y, col, tx, n) {
		return A2(
			$elm$core$String$join,
			'\n',
			_List_fromArray(
				[
					A5(
					$author$project$PageSvg$rect,
					x + 2,
					y,
					6,
					10,
					_List_fromArray(
						[
							A3($author$project$PageSvg$flStk, col, 'black', 0),
							A2($author$project$PageSvg$rxy, 1, 1),
							A3($author$project$PageSvg$rotate, 30, x + 5, y + 5)
						])),
					A4($author$project$CardSvg$jobTextn, x, y, tx, n)
				]));
	});
var $author$project$PageSvg$cxy = F2(
	function (x, y) {
		return $author$project$PageSvg$props(
			_List_fromArray(
				[
					A2($author$project$PageSvg$fprop, 'cx', x),
					A2($author$project$PageSvg$fprop, 'cy', y)
				]));
	});
var $author$project$PageSvg$cenRad = F4(
	function (cx, cy, rx, ry) {
		return $author$project$PageSvg$props(
			_List_fromArray(
				[
					A2($author$project$PageSvg$cxy, cx, cy),
					A2($author$project$PageSvg$rxy, rx, ry)
				]));
	});
var $author$project$PageSvg$circle = F4(
	function (x, y, r, pps) {
		return A2(
			$author$project$PageSvg$etag,
			'ellipse',
			A2(
				$elm$core$List$cons,
				A4($author$project$PageSvg$cenRad, x, y, r, r),
				pps));
	});
var $author$project$CardSvg$jobCircle = F5(
	function (x, y, col, tx, n) {
		return A2(
			$elm$core$String$join,
			'\n',
			_List_fromArray(
				[
					A4(
					$author$project$PageSvg$circle,
					x + 5,
					y + 5,
					5,
					_List_fromArray(
						[
							A3($author$project$PageSvg$flStk, col, 'Black', 1)
						])),
					A4($author$project$CardSvg$jobTextn, x, y, tx, n)
				]));
	});
var $author$project$CardSvg$jobRect = F5(
	function (x, y, col, tx, n) {
		return A2(
			$elm$core$String$join,
			'\n',
			_List_fromArray(
				[
					A5(
					$author$project$PageSvg$rect,
					x,
					y,
					10,
					10,
					_List_fromArray(
						[
							A3($author$project$PageSvg$flStk, col, 'Black', 1)
						])),
					A4($author$project$CardSvg$jobTextn, x, y, tx, n)
				]));
	});
var $author$project$Cards$resourceColor = function (r) {
	switch (r.$) {
		case 'Food':
			return 'green';
		case 'Iron':
			return 'silver';
		case 'Wood':
			return 'Brown';
		default:
			return 'Gold';
	}
};
var $author$project$Cards$resourceShortName = function (r) {
	switch (r.$) {
		case 'Gold':
			return 'Gld';
		case 'Wood':
			return 'Wd';
		case 'Iron':
			return 'Ir';
		default:
			return 'Fd';
	}
};
var $author$project$CardSvg$benefit = F3(
	function (x, y, b) {
		switch (b.$) {
			case 'Movement':
				var n = b.a;
				return A5($author$project$CardSvg$jobCircle, x, y, 'Pink', 'Mv', n);
			case 'Attack':
				var n = b.a;
				return A5($author$project$CardSvg$jobCircle, x, y, 'red', 'Atk', n);
			case 'Defend':
				var n = b.a;
				return A5($author$project$CardSvg$jobCircle, x, y, 'Grey', 'Dfd', n);
			case 'Gain':
				var r = b.a;
				var n = b.b;
				return A5(
					$author$project$CardSvg$jobRect,
					x,
					y,
					$author$project$Cards$resourceColor(r),
					$author$project$Cards$resourceShortName(r),
					n);
			case 'Draw':
				var n = b.a;
				return A5($author$project$CardSvg$jobCard, x, y, 'Green', '+', n);
			default:
				return '';
		}
	});
var $author$project$CardSvg$benefits = F3(
	function (xend, y, bens) {
		var x = xend - (10 * $elm$core$List$length(bens));
		return A2(
			$elm$core$String$join,
			'\n',
			A2(
				$elm$core$List$indexedMap,
				F2(
					function (n, b) {
						return A3($author$project$CardSvg$benefit, x + (n * 10), y, b);
					}),
				bens));
	});
var $author$project$Job$And = function (a) {
	return {$: 'And', a: a};
};
var $author$project$Job$N = function (a) {
	return {$: 'N', a: a};
};
var $author$project$Job$Or = function (a) {
	return {$: 'Or', a: a};
};
var $elm$core$Basics$negate = function (n) {
	return -n;
};
var $author$project$CardSvg$costLen = function (c) {
	switch (c.$) {
		case 'In':
			var inner = c.b;
			return 10 + $author$project$CardSvg$costLen(inner);
		case 'Or':
			var l = c.a;
			return A3(
				$elm$core$List$foldl,
				F2(
					function (i, n) {
						return (n + $author$project$CardSvg$costLen(i)) + 4;
					}),
				-4,
				l);
		case 'And':
			var l = c.a;
			return A3(
				$elm$core$List$foldl,
				F2(
					function (i, n) {
						return n + $author$project$CardSvg$costLen(i);
					}),
				0,
				l);
		case 'Free':
			return 0;
		default:
			return 10;
	}
};
var $elm$core$List$foldrHelper = F4(
	function (fn, acc, ctr, ls) {
		if (!ls.b) {
			return acc;
		} else {
			var a = ls.a;
			var r1 = ls.b;
			if (!r1.b) {
				return A2(fn, a, acc);
			} else {
				var b = r1.a;
				var r2 = r1.b;
				if (!r2.b) {
					return A2(
						fn,
						a,
						A2(fn, b, acc));
				} else {
					var c = r2.a;
					var r3 = r2.b;
					if (!r3.b) {
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(fn, c, acc)));
					} else {
						var d = r3.a;
						var r4 = r3.b;
						var res = (ctr > 500) ? A3(
							$elm$core$List$foldl,
							fn,
							acc,
							$elm$core$List$reverse(r4)) : A4($elm$core$List$foldrHelper, fn, acc, ctr + 1, r4);
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(
									fn,
									c,
									A2(fn, d, res))));
					}
				}
			}
		}
	});
var $elm$core$List$foldr = F3(
	function (fn, acc, ls) {
		return A4($elm$core$List$foldrHelper, fn, acc, 0, ls);
	});
var $elm$core$List$map = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						$elm$core$List$cons,
						f(x),
						acc);
				}),
			_List_Nil,
			xs);
	});
var $author$project$PageSvg$points = function (pts) {
	return A2(
		$author$project$PageSvg$prop,
		'points',
		A2(
			$elm$core$String$join,
			' ',
			A2($elm$core$List$map, $elm$core$String$fromFloat, pts)));
};
var $author$project$PageSvg$polygon = F2(
	function (pts, pps) {
		return A2(
			$author$project$PageSvg$etag,
			'polygon',
			A2(
				$elm$core$List$cons,
				$author$project$PageSvg$points(pts),
				pps));
	});
var $author$project$CardSvg$starPoints = F4(
	function (x, y, w, h) {
		var yy = function (n) {
			return y + ((h * n) * 0.1);
		};
		var xx = function (n) {
			return x + ((w * n) * 0.1);
		};
		return _List_fromArray(
			[
				xx(5),
				y,
				xx(6),
				yy(3),
				xx(10),
				yy(3),
				xx(7),
				yy(7),
				xx(6),
				yy(10),
				xx(5),
				yy(8),
				xx(4),
				yy(10),
				xx(3),
				yy(7),
				x,
				yy(3),
				xx(4),
				yy(3)
			]);
	});
var $author$project$CardSvg$jobStar = F4(
	function (x, y, col, n) {
		return A2(
			$elm$core$String$join,
			'\n',
			_List_fromArray(
				[
					A2(
					$author$project$PageSvg$polygon,
					A4($author$project$CardSvg$starPoints, x, y, 10, 10),
					_List_fromArray(
						[
							A3($author$project$PageSvg$flStk, col, 'black', 1)
						])),
					A3(
					$author$project$CardSvg$jobText,
					x + 5,
					y + 6,
					$author$project$Job$jnum(n))
				]));
	});
var $author$project$CardSvg$hexPoints = F4(
	function (x, y, w, h) {
		var y3 = y + h;
		var y2 = y + (h * 0.7);
		var y1 = y + (h * 0.3);
		var x2 = x + w;
		var x1 = x + (w * 0.5);
		return _List_fromArray(
			[x1, y, x2, y1, x2, y2, x1, y3, x, y2, x, y1]);
	});
var $author$project$Cards$placeColor = function (pl) {
	switch (pl.$) {
		case 'River':
			return 'Cyan';
		case 'Forest':
			return 'Green';
		case 'Mountain':
			return 'Grey';
		case 'Prarie':
			return 'LightGreen';
		case 'Water':
			return 'Blue';
		default:
			return 'Yellow';
	}
};
var $author$project$Cards$placeShortName = function (pl) {
	switch (pl.$) {
		case 'River':
			return 'Rvr';
		case 'Forest':
			return 'Frt';
		case 'Mountain':
			return 'Mtn';
		case 'Prarie':
			return 'Pry';
		case 'Water':
			return 'Wtr';
		default:
			return 'Vlg';
	}
};
var $author$project$CardSvg$place = F3(
	function (x, y, p) {
		return A2(
			$elm$core$String$join,
			'\n',
			_List_fromArray(
				[
					A2(
					$author$project$PageSvg$polygon,
					A4($author$project$CardSvg$hexPoints, x, y, 10, 10),
					_List_fromArray(
						[
							A3(
							$author$project$PageSvg$flStk,
							$author$project$Cards$placeColor(p),
							'black',
							1)
						])),
					A3(
					$author$project$CardSvg$jobText,
					x + 5,
					y + 4,
					$author$project$Cards$placeShortName(p))
				]));
	});
var $author$project$CardSvg$resource = F4(
	function (x, y, r, n) {
		return A2(
			$elm$core$String$join,
			'\n',
			_List_fromArray(
				[
					A5(
					$author$project$PageSvg$rect,
					x,
					y,
					10,
					10,
					_List_fromArray(
						[
							A3(
							$author$project$PageSvg$flStk,
							$author$project$Cards$resourceColor(r),
							'black',
							1)
						])),
					A4(
					$author$project$CardSvg$jobTextn,
					x,
					y,
					$author$project$Cards$resourceShortName(r),
					n)
				]));
	});
var $author$project$CardSvg$cost = F3(
	function (x, y, c) {
		cost:
		while (true) {
			switch (c.$) {
				case 'In':
					var p = c.a;
					var inner = c.b;
					return _Utils_ap(
						A3($author$project$CardSvg$place, x, y, p),
						A3($author$project$CardSvg$cost, x + 10, y, inner));
				case 'Or':
					if (!c.a.b) {
						return '';
					} else {
						if (!c.a.b.b) {
							var _v1 = c.a;
							var ic = _v1.a;
							var $temp$x = x,
								$temp$y = y,
								$temp$c = ic;
							x = $temp$x;
							y = $temp$y;
							c = $temp$c;
							continue cost;
						} else {
							var _v2 = c.a;
							var h = _v2.a;
							var t = _v2.b;
							return _Utils_ap(
								A3($author$project$CardSvg$cost, x, y, h),
								A3(
									$author$project$CardSvg$cost,
									(x + 4) + $author$project$CardSvg$costLen(h),
									y,
									$author$project$Job$Or(t)));
						}
					}
				case 'And':
					if (!c.a.b) {
						return '';
					} else {
						var _v3 = c.a;
						var h = _v3.a;
						var t = _v3.b;
						return _Utils_ap(
							A3($author$project$CardSvg$cost, x, y, h),
							A3(
								$author$project$CardSvg$cost,
								x + $author$project$CardSvg$costLen(h),
								y,
								$author$project$Job$And(t)));
					}
				case 'Discard':
					var n = c.a;
					return A5($author$project$CardSvg$jobCard, x, y, 'blue', 'dis', n);
				case 'Pay':
					var r = c.a;
					var n = c.b;
					return A4($author$project$CardSvg$resource, x, y, r, n);
				case 'ScrapC':
					return A5(
						$author$project$CardSvg$jobCard,
						x,
						y,
						'red',
						'scp',
						$author$project$Job$N(1));
				case 'Starter':
					var n = c.a;
					return A4($author$project$CardSvg$jobStar, x, y, 'white', n);
				default:
					return '';
			}
		}
	});
var $author$project$CardSvg$job = F2(
	function (y, jb) {
		return A3($author$project$CardSvg$cost, 5, y, jb.req) + ('\n' + A3($author$project$CardSvg$benefits, 45, y, jb._for));
	});
var $author$project$CardSvg$jobs = F2(
	function (y, l) {
		if (!l.b) {
			return '';
		} else {
			var h = l.a;
			var t = l.b;
			return _Utils_ap(
				A2($author$project$CardSvg$job, y, h),
				A2($author$project$CardSvg$jobs, y - 10, t));
		}
	});
var $author$project$PageSvg$strokeFirst = A2($author$project$PageSvg$prop, 'style', 'paint-order:stroke');
var $author$project$CardSvg$vcost = F3(
	function (x, y, c) {
		vcost:
		while (true) {
			switch (c.$) {
				case 'In':
					var p = c.a;
					var inner = c.b;
					return _Utils_ap(
						A3($author$project$CardSvg$place, x, y, p),
						A3($author$project$CardSvg$vcost, x, y + 10, inner));
				case 'Or':
					if (!c.a.b) {
						return '';
					} else {
						if (!c.a.b.b) {
							var _v1 = c.a;
							var ic = _v1.a;
							var $temp$x = x,
								$temp$y = y,
								$temp$c = ic;
							x = $temp$x;
							y = $temp$y;
							c = $temp$c;
							continue vcost;
						} else {
							var _v2 = c.a;
							var h = _v2.a;
							var t = _v2.b;
							return _Utils_ap(
								A3($author$project$CardSvg$vcost, x, y, h),
								A3(
									$author$project$CardSvg$vcost,
									x,
									(y + 4) + $author$project$CardSvg$costLen(h),
									$author$project$Job$Or(t)));
						}
					}
				case 'And':
					if (!c.a.b) {
						return '';
					} else {
						var _v3 = c.a;
						var h = _v3.a;
						var t = _v3.b;
						return _Utils_ap(
							A3($author$project$CardSvg$vcost, x, y, h),
							A3(
								$author$project$CardSvg$vcost,
								x,
								y + $author$project$CardSvg$costLen(h),
								$author$project$Job$And(t)));
					}
				default:
					return A3($author$project$CardSvg$cost, x, y, c);
			}
		}
	});
var $author$project$CardSvg$front = function (card) {
	return A2(
		$elm$core$String$join,
		'\n',
		_List_fromArray(
			[
				A5(
				$author$project$PageSvg$rect,
				0,
				0,
				50,
				70,
				_List_fromArray(
					[
						A3(
						$author$project$PageSvg$flStk,
						$author$project$Cards$cTypeColor(card.ctype),
						'none',
						0)
					])),
				A5(
				$author$project$PageSvg$rect,
				5,
				5,
				40,
				60,
				_List_fromArray(
					[
						$author$project$PageSvg$flNoStk('White'),
						A2($author$project$PageSvg$prop, 'opacity', '0.5')
					])),
				A4(
				$author$project$PageSvg$text,
				'Arial',
				10,
				_List_fromArray(
					[
						A2($author$project$PageSvg$xy, 20, 10),
						A3($author$project$PageSvg$flStk, 'Black', 'yellow', 0.5),
						$author$project$PageSvg$strokeFirst,
						$author$project$PageSvg$txCenter
					]),
				card.name),
				A3($author$project$CardSvg$vcost, 40, 5, card.cost),
				A2($author$project$CardSvg$jobs, 55, card.jobs)
			]));
};
var $author$project$PageSvg$nCardsFit = F4(
	function (margin, padding, page, card) {
		return $elm$core$Basics$floor((page - (margin * 2)) / (card + padding));
	});
var $elm$core$Basics$modBy = _Basics_modBy;
var $author$project$PageSvg$placeCardF = F5(
	function (nwide, fx, fy, n, theCard) {
		var y = (n / nwide) | 0;
		var x = A2($elm$core$Basics$modBy, nwide, n);
		return A2(
			$elm$core$String$join,
			'',
			_List_fromArray(
				[
					'<g transform="translate(',
					$elm$core$String$fromFloat(
					fx(x)),
					',',
					$elm$core$String$fromFloat(
					fy(y)),
					')">',
					theCard,
					'</g>'
				]));
	});
var $author$project$PageSvg$placeOneDir = F5(
	function (numCards, padding, page, card, n) {
		var step = card + padding;
		var nf = numCards;
		var start = ((page - (nf * card)) - ((nf - 1) * padding)) / 2;
		return start + (n * step);
	});
var $author$project$PageSvg$placeCarder = F6(
	function (margin, padding, pw, ph, cw, ch) {
		var nwide = A4($author$project$PageSvg$nCardsFit, margin, padding, pw, cw);
		var nhigh = A4($author$project$PageSvg$nCardsFit, margin, padding, ph, ch);
		var fy = A4($author$project$PageSvg$placeOneDir, nhigh, padding, ph, ch);
		var fx = A4($author$project$PageSvg$placeOneDir, nwide, padding, pw, cw);
		return A3($author$project$PageSvg$placeCardF, nwide, fx, fy);
	});
var $author$project$SvgMaker$placeCard = A6($author$project$PageSvg$placeCarder, 3, 0, 210, 297, 50, 70);
var $author$project$SvgMaker$listPage = function (l) {
	return $author$project$PageSvg$a4Page(
		A2(
			$elm$core$String$join,
			'\n',
			A2(
				$elm$core$List$indexedMap,
				F2(
					function (n, c) {
						return A2($author$project$SvgMaker$placeCard, n, c);
					}),
				A2($elm$core$List$map, $author$project$CardSvg$front, l))));
};
var $elm$json$Json$Encode$object = function (pairs) {
	return _Json_wrap(
		A3(
			$elm$core$List$foldl,
			F2(
				function (_v0, obj) {
					var k = _v0.a;
					var v = _v0.b;
					return A3(_Json_addField, k, v, obj);
				}),
			_Json_emptyObject(_Utils_Tuple0),
			pairs));
};
var $elm$json$Json$Encode$string = _Json_wrap;
var $author$project$SvgMaker$log = _Platform_outgoingPort(
	'log',
	function ($) {
		return $elm$json$Json$Encode$object(
			_List_fromArray(
				[
					_Utils_Tuple2(
					'content',
					$elm$json$Json$Encode$string($.content)),
					_Utils_Tuple2(
					'fname',
					$elm$json$Json$Encode$string($.fname))
				]));
	});
var $author$project$MLists$spreadItem = F2(
	function (_v0, l) {
		spreadItem:
		while (true) {
			var a = _v0.a;
			var n = _v0.b;
			if (!n) {
				return l;
			} else {
				var $temp$_v0 = _Utils_Tuple2(a, n - 1),
					$temp$l = A2($elm$core$List$cons, a, l);
				_v0 = $temp$_v0;
				l = $temp$l;
				continue spreadItem;
			}
		}
	});
var $author$project$MLists$spreadL = function (l) {
	if (!l.b) {
		return _List_Nil;
	} else {
		var _v1 = l.a;
		var a = _v1.a;
		var n = _v1.b;
		var t = l.b;
		return A2(
			$author$project$MLists$spreadItem,
			_Utils_Tuple2(a, n),
			$author$project$MLists$spreadL(t));
	}
};
var $author$project$Cards$Card = F4(
	function (name, ctype, cost, jobs) {
		return {cost: cost, ctype: ctype, jobs: jobs, name: name};
	});
var $author$project$Job$Food = {$: 'Food'};
var $author$project$Job$Forest = {$: 'Forest'};
var $author$project$Job$In = F2(
	function (a, b) {
		return {$: 'In', a: a, b: b};
	});
var $author$project$Job$Iron = {$: 'Iron'};
var $author$project$Job$Job = F2(
	function (req, _for) {
		return {_for: _for, req: req};
	});
var $author$project$Cards$TAttack = {$: 'TAttack'};
var $author$project$Job$Wood = {$: 'Wood'};
var $author$project$Job$Attack = function (a) {
	return {$: 'Attack', a: a};
};
var $author$project$Job$attack = function (n) {
	return $author$project$Job$Attack(
		$author$project$Job$N(n));
};
var $author$project$Job$Gain = F2(
	function (a, b) {
		return {$: 'Gain', a: a, b: b};
	});
var $author$project$Job$gain = F2(
	function (r, n) {
		return A2(
			$author$project$Job$Gain,
			r,
			$author$project$Job$N(n));
	});
var $author$project$Job$Pay = F2(
	function (a, b) {
		return {$: 'Pay', a: a, b: b};
	});
var $author$project$Job$pay = F2(
	function (r, n) {
		return A2(
			$author$project$Job$Pay,
			r,
			$author$project$Job$N(n));
	});
var $author$project$Job$payEq = F2(
	function (n, l) {
		return $author$project$Job$And(
			A2(
				$elm$core$List$map,
				function (r) {
					return A2(
						$author$project$Job$Pay,
						r,
						$author$project$Job$N(n));
				},
				l));
	});
var $author$project$Cards$bow = A4(
	$author$project$Cards$Card,
	'Bow',
	$author$project$Cards$TAttack,
	A2(
		$author$project$Job$payEq,
		1,
		_List_fromArray(
			[$author$project$Job$Wood, $author$project$Job$Iron])),
	_List_fromArray(
		[
			A2(
			$author$project$Job$Job,
			A2(
				$author$project$Job$In,
				$author$project$Job$Forest,
				A2($author$project$Job$pay, $author$project$Job$Wood, 1)),
			_List_fromArray(
				[
					A2($author$project$Job$gain, $author$project$Job$Food, 3)
				])),
			A2(
			$author$project$Job$Job,
			A2($author$project$Job$pay, $author$project$Job$Wood, 1),
			_List_fromArray(
				[
					$author$project$Job$attack(3)
				]))
		]));
var $author$project$Job$Gold = {$: 'Gold'};
var $author$project$Job$Prarie = {$: 'Prarie'};
var $author$project$Cards$TMove = {$: 'TMove'};
var $author$project$Job$Village = {$: 'Village'};
var $author$project$Job$Movement = function (a) {
	return {$: 'Movement', a: a};
};
var $author$project$Cards$foodMove = F2(
	function (f, d) {
		return A2(
			$author$project$Job$Job,
			A2(
				$author$project$Job$Pay,
				$author$project$Job$Food,
				$author$project$Job$N(f)),
			_List_fromArray(
				[
					$author$project$Job$Movement(
					$author$project$Job$N(d))
				]));
	});
var $author$project$Job$ScrapC = {$: 'ScrapC'};
var $author$project$Cards$scrapFor = F2(
	function (r, n) {
		return A2(
			$author$project$Job$Job,
			$author$project$Job$ScrapC,
			_List_fromArray(
				[
					A2($author$project$Job$gain, r, n)
				]));
	});
var $author$project$Cards$horse = A4(
	$author$project$Cards$Card,
	'Horse',
	$author$project$Cards$TMove,
	$author$project$Job$Or(
		_List_fromArray(
			[
				A2(
				$author$project$Job$In,
				$author$project$Job$Prarie,
				A2($author$project$Job$pay, $author$project$Job$Food, 3)),
				A2(
				$author$project$Job$In,
				$author$project$Job$Village,
				A2($author$project$Job$pay, $author$project$Job$Gold, 1))
			])),
	_List_fromArray(
		[
			A2($author$project$Cards$foodMove, 1, 1),
			A2($author$project$Cards$scrapFor, $author$project$Job$Food, 5)
		]));
var $author$project$Job$Free = {$: 'Free'};
var $author$project$Job$Starter = function (a) {
	return {$: 'Starter', a: a};
};
var $author$project$Cards$TGold = {$: 'TGold'};
var $author$project$Job$Gather = F2(
	function (a, b) {
		return {$: 'Gather', a: a, b: b};
	});
var $author$project$Job$River = {$: 'River'};
var $author$project$Cards$riverGather = function (n) {
	return A2(
		$author$project$Job$Job,
		A2($author$project$Job$In, $author$project$Job$River, $author$project$Job$Free),
		_List_fromArray(
			[
				A2(
				$author$project$Job$Gather,
				$author$project$Job$Gold,
				$author$project$Job$N(n))
			]));
};
var $author$project$Cards$pan = A4(
	$author$project$Cards$Card,
	'Pan',
	$author$project$Cards$TGold,
	$author$project$Job$Or(
		_List_fromArray(
			[
				$author$project$Job$Starter(
				$author$project$Job$N(2)),
				A2($author$project$Job$In, $author$project$Job$Village, $author$project$Job$Free)
			])),
	_List_fromArray(
		[
			$author$project$Cards$riverGather(1)
		]));
var $author$project$Cards$starterDeck = _List_fromArray(
	[
		_Utils_Tuple2($author$project$Cards$pan, 2),
		_Utils_Tuple2($author$project$Cards$horse, 2),
		_Utils_Tuple2($author$project$Cards$bow, 2)
	]);
var $author$project$Cards$TWork = {$: 'TWork'};
var $author$project$Job$Discard = function (a) {
	return {$: 'Discard', a: a};
};
var $author$project$Job$discard = function (n) {
	return $author$project$Job$Discard(
		$author$project$Job$N(n));
};
var $author$project$Cards$saw = A4(
	$author$project$Cards$Card,
	'Saw',
	$author$project$Cards$TWork,
	A2($author$project$Job$pay, $author$project$Job$Iron, 1),
	_List_fromArray(
		[
			A2(
			$author$project$Job$Job,
			A2(
				$author$project$Job$In,
				$author$project$Job$Forest,
				$author$project$Job$discard(1)),
			_List_fromArray(
				[
					A2($author$project$Job$gain, $author$project$Job$Wood, 3)
				]))
		]));
var $author$project$Cards$freeAttack = function (a) {
	return A2(
		$author$project$Job$Job,
		$author$project$Job$Free,
		_List_fromArray(
			[
				$author$project$Job$attack(a)
			]));
};
var $author$project$Job$Defend = function (a) {
	return {$: 'Defend', a: a};
};
var $author$project$Job$defend = function (n) {
	return $author$project$Job$Defend(
		$author$project$Job$N(n));
};
var $author$project$Cards$freeDefend = function (d) {
	return A2(
		$author$project$Job$Job,
		$author$project$Job$Free,
		_List_fromArray(
			[
				$author$project$Job$defend(d)
			]));
};
var $author$project$Cards$sword = A4(
	$author$project$Cards$Card,
	'Sword',
	$author$project$Cards$TAttack,
	A2(
		$author$project$Job$payEq,
		1,
		_List_fromArray(
			[$author$project$Job$Iron, $author$project$Job$Wood])),
	_List_fromArray(
		[
			$author$project$Cards$freeAttack(5),
			$author$project$Cards$freeDefend(1)
		]));
var $author$project$Job$payL = function (l) {
	return $author$project$Job$And(
		A2(
			$elm$core$List$map,
			function (_v0) {
				var r = _v0.a;
				var n = _v0.b;
				return A2($author$project$Job$pay, r, n);
			},
			l));
};
var $author$project$Cards$woodMove = F2(
	function (w, d) {
		return A2(
			$author$project$Job$Job,
			A2($author$project$Job$pay, $author$project$Job$Wood, w),
			_List_fromArray(
				[
					$author$project$Job$Movement(
					$author$project$Job$N(d))
				]));
	});
var $author$project$Cards$train = A4(
	$author$project$Cards$Card,
	'Train',
	$author$project$Cards$TMove,
	$author$project$Job$payL(
		_List_fromArray(
			[
				_Utils_Tuple2($author$project$Job$Iron, 3),
				_Utils_Tuple2($author$project$Job$Wood, 1)
			])),
	_List_fromArray(
		[
			A2($author$project$Cards$woodMove, 1, 3),
			A2($author$project$Cards$scrapFor, $author$project$Job$Wood, 5)
		]));
var $author$project$Cards$twinSwords = A4(
	$author$project$Cards$Card,
	'Twin Swords',
	$author$project$Cards$TAttack,
	$author$project$Job$payL(
		_List_fromArray(
			[
				_Utils_Tuple2($author$project$Job$Iron, 3),
				_Utils_Tuple2($author$project$Job$Wood, 2)
			])),
	_List_fromArray(
		[
			$author$project$Cards$freeAttack(12),
			$author$project$Cards$freeDefend(5)
		]));
var $author$project$Job$Draw = function (a) {
	return {$: 'Draw', a: a};
};
var $author$project$Job$draw = function (n) {
	return $author$project$Job$Draw(
		$author$project$Job$N(n));
};
var $author$project$Cards$wagon = A4(
	$author$project$Cards$Card,
	'Wagon',
	$author$project$Cards$TMove,
	A2($author$project$Job$pay, $author$project$Job$Wood, 2),
	_List_fromArray(
		[
			A2(
			$author$project$Job$Job,
			$author$project$Job$ScrapC,
			_List_fromArray(
				[
					A2($author$project$Job$gain, $author$project$Job$Wood, 2),
					A2($author$project$Job$gain, $author$project$Job$Food, 2),
					$author$project$Job$draw(2)
				])),
			A2(
			$author$project$Job$Job,
			$author$project$Job$Free,
			_List_fromArray(
				[
					A2($author$project$Job$gain, $author$project$Job$Wood, 1),
					A2($author$project$Job$gain, $author$project$Job$Food, 1),
					$author$project$Job$draw(1)
				]))
		]));
var $author$project$Cards$tradeRow = _List_fromArray(
	[
		_Utils_Tuple2($author$project$Cards$pan, 3),
		_Utils_Tuple2($author$project$Cards$saw, 2),
		_Utils_Tuple2($author$project$Cards$horse, 2),
		_Utils_Tuple2($author$project$Cards$twinSwords, 2),
		_Utils_Tuple2($author$project$Cards$wagon, 3),
		_Utils_Tuple2($author$project$Cards$sword, 3),
		_Utils_Tuple2($author$project$Cards$train, 2),
		_Utils_Tuple2($author$project$Cards$bow, 3)
	]);
var $author$project$SvgMaker$starterList = $author$project$MLists$spreadL(
	_Utils_ap($author$project$Cards$starterDeck, $author$project$Cards$tradeRow));
var $elm$core$List$takeReverse = F3(
	function (n, list, kept) {
		takeReverse:
		while (true) {
			if (n <= 0) {
				return kept;
			} else {
				if (!list.b) {
					return kept;
				} else {
					var x = list.a;
					var xs = list.b;
					var $temp$n = n - 1,
						$temp$list = xs,
						$temp$kept = A2($elm$core$List$cons, x, kept);
					n = $temp$n;
					list = $temp$list;
					kept = $temp$kept;
					continue takeReverse;
				}
			}
		}
	});
var $elm$core$List$takeTailRec = F2(
	function (n, list) {
		return $elm$core$List$reverse(
			A3($elm$core$List$takeReverse, n, list, _List_Nil));
	});
var $elm$core$List$takeFast = F3(
	function (ctr, n, list) {
		if (n <= 0) {
			return _List_Nil;
		} else {
			var _v0 = _Utils_Tuple2(n, list);
			_v0$1:
			while (true) {
				_v0$5:
				while (true) {
					if (!_v0.b.b) {
						return list;
					} else {
						if (_v0.b.b.b) {
							switch (_v0.a) {
								case 1:
									break _v0$1;
								case 2:
									var _v2 = _v0.b;
									var x = _v2.a;
									var _v3 = _v2.b;
									var y = _v3.a;
									return _List_fromArray(
										[x, y]);
								case 3:
									if (_v0.b.b.b.b) {
										var _v4 = _v0.b;
										var x = _v4.a;
										var _v5 = _v4.b;
										var y = _v5.a;
										var _v6 = _v5.b;
										var z = _v6.a;
										return _List_fromArray(
											[x, y, z]);
									} else {
										break _v0$5;
									}
								default:
									if (_v0.b.b.b.b && _v0.b.b.b.b.b) {
										var _v7 = _v0.b;
										var x = _v7.a;
										var _v8 = _v7.b;
										var y = _v8.a;
										var _v9 = _v8.b;
										var z = _v9.a;
										var _v10 = _v9.b;
										var w = _v10.a;
										var tl = _v10.b;
										return (ctr > 1000) ? A2(
											$elm$core$List$cons,
											x,
											A2(
												$elm$core$List$cons,
												y,
												A2(
													$elm$core$List$cons,
													z,
													A2(
														$elm$core$List$cons,
														w,
														A2($elm$core$List$takeTailRec, n - 4, tl))))) : A2(
											$elm$core$List$cons,
											x,
											A2(
												$elm$core$List$cons,
												y,
												A2(
													$elm$core$List$cons,
													z,
													A2(
														$elm$core$List$cons,
														w,
														A3($elm$core$List$takeFast, ctr + 1, n - 4, tl)))));
									} else {
										break _v0$5;
									}
							}
						} else {
							if (_v0.a === 1) {
								break _v0$1;
							} else {
								break _v0$5;
							}
						}
					}
				}
				return list;
			}
			var _v1 = _v0.b;
			var x = _v1.a;
			return _List_fromArray(
				[x]);
		}
	});
var $elm$core$List$take = F2(
	function (n, list) {
		return A3($elm$core$List$takeFast, 0, n, list);
	});
var $author$project$SvgMaker$update = F2(
	function (ms, mod) {
		if (ms.$ === 'Next') {
			return _Utils_Tuple2(
				_Utils_update(
					mod,
					{pos: mod.pos + 16}),
				function () {
					var _v1 = A2(
						$elm$core$List$take,
						16,
						A2($elm$core$List$drop, mod.pos, $author$project$SvgMaker$starterList));
					if (!_v1.b) {
						return $elm$core$Platform$Cmd$none;
					} else {
						var l = _v1;
						return $author$project$SvgMaker$log(
							A2(
								$author$project$SvgMaker$Writer,
								'out' + ($elm$core$String$fromInt(mod.pos) + '.svg'),
								$author$project$SvgMaker$listPage(l)));
					}
				}());
		} else {
			return _Utils_Tuple2(mod, $elm$core$Platform$Cmd$none);
		}
	});
var $elm$core$Platform$worker = _Platform_worker;
var $author$project$SvgMaker$main = $elm$core$Platform$worker(
	{init: $author$project$SvgMaker$init, subscriptions: $author$project$SvgMaker$subscriptions, update: $author$project$SvgMaker$update});
_Platform_export({'SvgMaker':{'init':$author$project$SvgMaker$main(
	$elm$json$Json$Decode$succeed(_Utils_Tuple0))(0)}});}(this));