\documentclass[11pt]{article}
%include lhs2TeX.fmt
\usepackage[utf8]{inputenc}

\usepackage[T1]{fontenc}
\usepackage[sc]{mathpazo}
\linespread{1.05}
\usepackage{helvet}

\usepackage{multicol}
\usepackage{float}
\usepackage[landscape, top=0.2in, bottom=1in, left=0.2in, right=0.2in, dvips]{geometry}
\usepackage{verbatim}
\usepackage{fancyhdr}
\usepackage{paralist}
\usepackage[hide]{todo}

\usepackage{hyperref}
\usepackage[all]{hypcap} % Must be after hyperref
\hypersetup{colorlinks}

\pagestyle{fancy}
\fancyhf{}
\lfoot{\copyright\ 2009 Justin Bailey.}
\cfoot{\thepage}
\rfoot{\href{mailto:jgbailey@@codeslower.com}{\tt jgbailey@@codeslower.com}}
\renewcommand\footrulewidth{0.4pt}

\makeatletter
% Copied from article.cls; second-to-last parameter changed to -\parindent.
\renewcommand\subsubsection{\@@startsection{subsubsection}{3}{\z@@}%
  {-3.25ex \@@plus -1ex \@@minus -.2ex}%
  {-\parindent}%
  {\normalfont\normalsize\bfseries}}
\makeatother

\newcommand{\hd}[1]{\section*{\textsf{#1}}}
\newcommand{\shd}[1]{\subsection*{\textsf{#1}}}
\newcommand{\sshd}[1]{\subsubsection*{\textsf{#1}}}
\setlength{\columnsep}{18.0pt}
\setlength{\columnseprule}{0.4pt}
\begin{document}
\begin{multicols}{3}
\section*{\textsf{\LARGE Guía Rápida de Haskell\normalsize}}\label{preamble}

Esta guía rápida abarca los elementos fundamentales del lenguaje Haskell:
sintaxis, palabras clave y otros elementos. Se presenta como un archivo 
ejecutable de Haskell y también como un documento para impresión. Cargue 
la fuente en su intérprete favorito para jugar con los ejemplos de código
mostrados.

% This cheat sheet lays out the fundamental elements of the Haskell language:
% syntax, keywords and other elements. It is presented as both an executable
% Haskell file and a printable document. Load the source into your favorite
% i nterpreter to play with code samples shown.

\begin{comment}

> {-# LANGUAGE MultiParamTypeClasses #-}
>
> module CheatSheet where
>
> import Data.Char (isUpper, isLower, toUpper, toLower, isSpace, GeneralCategory(..))
> import System.IO (readFile)
> import System.Directory (doesFileExist)
> import qualified Data.Set as Set
> import qualified Data.Char as Char

\end{comment}

\hd{Sintaxis Básica}\label{syntax}

\shd{Comentarios}\label{comments}

  Un comentario de una sola línea comienza con `@--@' y se extiende hasta el
  final de la línea. Los comentarios de varias líneas comienzan con '@{-@' y se 
  extienden hasta '@-}@'. Los comentarios pueden ser anidados.

%  A single line comment starts with `@--@' and extends to the end of the line.
%  Multi-line comments start with '@{-@' and extend to '@-}@'. Comments can be
%  nested.

  Los comentarios antes de las definiciones de función deben comenzar con `@{- |@'
  y los que están junto a los tipos de parámetros con `@-- ^@' para que sean 
  compatibles con Haddock, un sistema para documentar código en Haskell.

%  Comments above function definitions should start with `@{- |@' and those next
%  to parameter types with `@-- ^@' for compatibility with
%  Haddock, a system for documenting
%  Haskell code.

\shd{Palabras Reservadas}\label{reserved-words}

%\shd{Reserved Words}\label{reserved-words}

  Las siguientes palabras están reservadas para Haskell. Es un error de sintaxis
  darle a una variable o a una función uno de estos nombres.

%  The following words are reserved in Haskell. It is a syntax error to give a
%  variable or a function one of these names.

  \setlength{\columnsep}{10.0pt}
  \setlength{\columnseprule}{0.0pt}
  \begin{multicols}{3}
    \begin{compactitem}
      \item @case@
      \item @class@
      \item @data@
      \item @deriving@
      \item @do@
      \item @else@
      \item @if@
      \item @import@
      \item @in@
      \item @infix@
      \item @infixl@
      \item @infixr@
      \item @instance@
      \item @let@
      \item @of@
      \item @module@
      \item @newtype@
      \item @then@
      \item @type@
      \item @where@
    \end{compactitem}
  \end{multicols}
  \setlength{\columnsep}{18.0pt}
  \setlength{\columnseprule}{0.4pt}

\shd{Cadenas}\label{strings}

  \begin{compactitem}
  \item @"abc"@ -- Cadena Unicode string, azúcar sintáctica de @['a','b','c']@.
  \item @'a'@ -- Un solo caracter.
%  \item @"abc"@ -- Unicode string, sugar for @['a','b','c']@.
%  \item @'a'@ -- Single character.
  \end{compactitem}

  \sshd{Cadenas en varias líneas}\label{multi-line-strings}
%  \sshd{Multi-line Strings}\label{multi-line-strings}

  Normalmente, es un error de sintaxis si una cadena contiene caracteres de fin 
  de línea. Eso es, esto es un error de sintaxis:

%  Normally, it is a syntax error if a string has any newline characters.
%  That is, this is a syntax error:

< string1 = "My long
< string."

  Se pueden emplear barras diagonales inversas (`@\@') para hacer ``escape'' de un 
  fin de línea:

%  Backslashes (`@\@') can ``escape'' a newline:

> string1 = "My long \
> \string."

  El área entre las barras diagonales inversas es ignorada. Los fines de línea \emph{en}
  la cadena deben ser representados explícitamente:

%  The area between the backslashes is ignored. Newlines \emph{in} the
%  string must be represented explicitly:

> string2 = "My long \n\
> \string."

  Eso es, @string1@ evalúa como 

%  That is, @string1@ evaluates to:

< My long string.

  Mientras @string2@ evalúa como:

%  While @string2@ evaluates to:

< My long
< string.


  \sshd{Códigos de escape} Los siguientes códigos de escape pueden ser utilizados en caracteres o cadenas:
%  \sshd{Escape Codes} The following escape codes can be used in characters or strings:
  \begin{compactitem}
    \item @\n@, @\r@, @\f@, etc. -- Los códigos estándar para fin de línea, retorno de carro, avance de línea, etc. 
    \item @\72@, @\x48@, @\o110@ -- Un caracter con el valor 72 en decimal, hexadecimal y octal, respectivamente. 
    \item @\&@ -- El caracter de escape ``null'', es utilizado para que los códigos de escape numéricos puedan aparecer junto de las literales numéricas. Es equivalente a ``'' y por lo tanto no puede ser utilizado en literales de caracter. 
    \todo{Caracteres de control, códigos ascii como NUL}
%    \item @\n@, @\r@, @\f@, etc. -- The standard codes for newline, carriage return, form feed, etc. are supported.
%    \item @\72@, @\x48@, \@o110@ -- A character with the value 72 in decimal, hex and octal, respectively.
%    \item @\&@ -- The ``null'' escape character, it is used so numeric escape codes can appear next to numeric literals. Equivalent to ``'' and therefore cannot be used in character literals.
%    \todo{Control characters, ascii codes such as NUL}
  \end{compactitem}
  

\shd{Números}\label{numbers}

  \begin{compactitem}
  \item @1@ -- Entero o valor de punto flotante.
  \item @1.0, 1e10@ -- Valor de punto flotante.
  \item @0o1, 0O1@ -- Valor octal.
  \item @0x1, 0X1@ -- Valor hexadecimal.
 \item  @-1@ -- Número negativo; el signo de menos (``@-@'') no puede ir separado del número.
%  \item @1@ -- Integer or floating point value.
%  \item @1.0, 1e10@ -- Floating point value.
%  \item @0o1, 0O1@ -- Octal value.
%  \item @0x1, 0X1@ -- Hexadecimal value.
% \item  @-1@ -- Negative number; the minus sign (``@-@'') cannot be separated from the number.
  \end{compactitem}

\shd{Enumeraciones}\label{enumerations}

  \begin{compactitem}
  \item @[1..10]@ -- Lista de números -- \texttt{1, 2, {\ensuremath\mathellipsis}, 10}.
  \item @[100..]@ -- Lista infinita de números -- \texttt{100, 101, 102, {\ensuremath\mathellipsis}\ }.
  \item @[110..100]@ -- Lista vacía; los rangos solamente avanzan hacia adelante.
  \item @[0, -1 ..]@ -- Enteros negativos.
  \item @[-110..-100]@ -- Error de sintaxis; necesita @[-110.. -100]@ por los negativos.
  \item @[1,3..99], [-1,3..99]@ -- Lista de 1 a 99, de 2 en 2; y de -1 a 99, de 4 en 4.  
%  \item @[1..10]@ -- List of numbers -- \texttt{1, 2, {\ensuremath\mathellipsis}, 10}.
%  \item @[100..]@ -- Infinite list of numbers -- \texttt{100, 101, 102, {\ensuremath\mathellipsis}\ }.
%  \item @[110..100]@ -- Empty list; ranges only go forwards.
%  \item @[0, -1 ..]@ -- Negative integers.
%  \item @[-110..-100]@ -- Syntax error; need @[-110.. -100]@ for negatives.
%  \item @[1,3..99], [-1,3..99]@ -- List from 1 to 99 by 2, -1 to 99 by 4.  
  \end{compactitem}

%  \noindent In fact, any value which is in the @Enum@ class can be used:
  \noindent De hecho, se puede usar cualquier valor que esté en la clase @Enum@:

  \begin{compactitem}
  \item @['a' .. 'z']@ -- Lista of caracteres -- \texttt{a, b, {\ensuremath\mathellipsis}, z}.
  \item @[1.0, 1.5 .. 2]@ -- @[1.0,1.5,2.0]@.
  \item @[UppercaseLetter ..]@ -- Lista de valores @GeneralCategory@ (en @Data.Char@).
%  \item @['a' .. 'z']@ -- List of characters -- \texttt{a, b, {\ensuremath\mathellipsis}, z}.
%  \item @[1.0, 1.5 .. 2]@ -- @[1.0,1.5,2.0]@.
%  \item @[UppercaseLetter ..]@ -- List of @GeneralCategory@ values (from @Data.Char@).
  \end{compactitem}

\shd{Listas \& Tuplas}\label{lists-tuples}

  \begin{compactitem}
  \item @[]@ -- Lista vacía.
  \item @[1,2,3]@ -- Lista de tres números.
  \item @1 : 2 : 3 : []@ -- Forma alterna de escribir listas usando ``cons'' (@:@) y ``nil'' (@[]@).
  \item @"abc"@ -- Lista de tres caracteres (las cadenas son listas).
  \item @'a' : 'b' : 'c' : []@ -- Lista de caracteres (lo mismo que @"abc"@).
  \item @(1,"a")@ -- Tupla de dos elementos, un número y una cadena.
  \item @(head, tail, 3, 'a')@ -- Tupla de cuatro elementos, dos funciones, un número y un caracter.
%  \item @[]@ -- Empty list.
%  \item @[1,2,3]@ -- List of three numbers.
%  \item @1 : 2 : 3 : []@ -- Alternate way to write lists using ``cons'' (@:@) and ``nil'' (@[]@).
%  \item @"abc"@ -- List of three characters (strings are lists).
%  \item @'a' : 'b' : 'c' : []@ -- List of characters (same as @"abc"@).
%  \item @(1,"a")@ -- 2-element tuple of a number and a string.
%  \item @(head, tail, 3, 'a')@ -- 4-element tuple of two functions, a number and a character.
  \end{compactitem}

\shd{Regla ``Layout'', llaves y punto y comas}\label{layout}

 Se puede escribir Haskell utilizando llaves y punto y comas, igual que en C. 
 Sin embargo, nadie lo hace. En lugar de eso se emplea la regla ``layout'', donde
 se emplea espacio en blanco para separar contextos. La regla general es: siempre 
 usar sangrías. Cuando el compilador se queje, usar más.

% Haskell can be written using braces and semi-colons, just like C. However, no
% one does. Instead, the ``layout'' rule is used, where spaces represent scope.
% The general rule is: always indent. When the compiler complains, indent more.

  \sshd{Llaves y punto y comas}\label{braces-semicolons}

  Los paréntesis finalizan una expresión, y las llaves representan contextos. Pueden
  ser utilizados después de varias palabras clave: @where@, @let@, @do@ y @of@. No
  pueden ser utilizados al definir el cuerpo de una función. Por ejemplo, esto no
  compila:

%  Semi-colons terminate an expression, and braces represent scope. They can be
%  used after several keywords: @where@, @let@, @do@ and @of@. They cannot be
%  used when defining a function body. For example, the below will not compile.

<    square2 x = { x * x; }

  Sin embargo, esto funciona bien:

%  However, this will work fine:


> square2 x = result
>     where { result = x * x; }

  \sshd{Definición de funciones}\label{layout-function-definition}

  Aplique una sangría de al menos un espacio a partir del nombre de la función:

%  Indent the body at least one space from the function name:

< square x  =
<   x * x

  A menos que esté presente una cláusula @where@. En ese caso, aplique la sangría
  de la cláusula @where@ al menos un espacio a partir del nombre de la función y
  todos los cuerpos de la función al menos a un espacio a partir de la palabra clave
  @where@:

%  Unless a @where@ clause is present. In that case, indent the where clause at
%  least one space from the function name and any function bodies at least one
%  space from the @where@ keyword:

<  square x =
<      x2
<    where x2 =
<      x * x

  \sshd{Let}\label{layout-let}


  Aplique sangría sobre el cuerpo del @let@ al menos un espacio a partir de la primera
  definición en el @let@. Si el @let@ aparece por sí solo en una línea, el cuerpo de 
  cualquier definición debe aparecer en la columna después del @let@:

%  Indent the body of the let at least one space from the first definition in the
%  @let@. If @let@ appears on its own line, the body of any definition must
%  appear in the column after the let:

<  square x =
<    let x2 =
<          x * x
<    in x2

  Como se puede ver arriba, la palabra clave @in2@ debe también estar en la misma columna
  que el @let@. Finalmente, cuando se van múltiples definiciones, todos los identificadores
  deben aparecer en la misma columna.

%  As can be seen above, the @in@ keyword must also be in the same column as
%  @let@. Finally, when multiple definitions are given, all identifiers must
%  appear in the same column.

\hd{Declaraciones, Etc.}\label{declarations}

  La siguiente sección describe las reglas para la declaración de funciones, las listas por
  comprensión, y otras áreas del lenguaje.

%  The following section details rules on function declarations, list
%  comprehensions, and other areas of the language.

\shd{Definición de Funciones}\label{function-definition}

  Las funciones se definen declarando su nombre, los argumentos, y un signo de igual:

%  Functions are defined by declaring their name, any arguments, and an equals
%  sign:

> square x = x * x

  \emph{Todos} los nombres de función deben comenzar con letra minúscula o ``@_@''. Es un error
  de sintaxis de cualquier otra forma.

%  \emph{All} functions names must start with a lowercase letter or ``@_@''. It
%  is a syntax error otherwise.

  \sshd{Comparación de patrones}\label{pattern-matching}

  Se pueden definir varias ``cláusulas'' de una función haciendo ``comparación de patrones''
  en los valores de los argumentos. Aquí, la función @agree@ tiene cuatro casos separados:

%  Multiple ``clauses'' of a function can be defined by ``pattern-matching'' on
%  the values of arguments. Here, the the @agree@ function has four separate
%  cases:

> -- Coincide cuando se da la cadena "y".
> agree1 "y" = "Great!"
> -- Coincide cuando se da la cadena "n".
> agree1 "n" = "Too bad."
> -- Coincide cuando se da una cadena que
> -- comienza con 'y'.
> agree1 ('y':_) = "YAHOO!"
> -- Coincide con cualquier otro valor.
> agree1 _ = "SO SAD."


  Nótese que el caracter `@_@' es un comodín y coincide con cualquier valor.

%  Note that the `@_@' character is a wildcard and matches any value.

  La comparación de patrones se puede extender a valores anidados. Asumiendo esta
  declaración de dato:

%  Pattern matching can extend to nested values. Assuming this data declaration:

< data Bar = Bil (Maybe Int) | Baz

  \noindent y recordando la \hyperref[maybe]{definición de @Maybe@} de la 
  página~\pageref{maybe} podemos hacer coincidir en valores @Maybe@ anidados 
  cuando @Bil@ está presente:

%  \noindent and recalling the \hyperref[maybe]{definition of @Maybe@} from
%  page~\pageref{maybe} we can match on nested @Maybe@ values when @Bil@ is
%  present:

< f (Bil (Just _)) = ...
< f (Bil Nothing) = ...
< f Baz = ...

  La comparación de patrones también permite que valores sean asociados a variables.
  Por ejemplo, esta función determina si la cadena dada es o no vacía. Si no, el valor
  asociado a @str@ es convertido a minúsculas:

%  Pattern-matching also allows values to be assigned to variables. For example,
%  this function determines if the string given is empty or not. If not, the
%  value bound to @str@ is converted to lower case:

> toLowerStr [] = []
> toLowerStr str = map toLower str

  Nótese que aquí @str@ es similar a @_@ en que va a coincidir con lo que sea; la única
  diferencia es que al valor que coincide también se le da un nombre.

%  Note that @str@ above is similer to @_@ in that it will match anything; the
%  only difference is that the value matched is also given a name.

  \sshd{{\ensuremath $n + k$} Patterns}\label{plus-patterns}

  Esta (a veces controversial) comparación de patrones hace fácil coincidir con ciertos
  tipos de expresiones numéricas. La idea es definir un caso base (la porción ``$n$'') con
  un número constante para que coincida, y después definir las coincidencias (la porción ``$k$'')
  como sumas sobre el caso base. Por ejemplo, esta es una forma ineficiente de determinar si
  un número es o no par:

%  This (sometimes controversial) pattern-matching facility makes it easy to match
%  certain kinds of numeric expressions. The idea is to define a base case (the
%  ``$n$'' portion) with a constant number for matching, and then to define other
%  matches (the ``$k$'' portion) as additives to the base case. Here is a rather
%  inefficient way of testing if a number is even or not:

> isEven 0 = True
> isEven 1 = False
> isEven (n + 2) = isEven n

  \sshd{Captura de Argumentos}\label{argument-capture}

  La captura de argumentos es útil para comparar un patrón \emph{y} utilizarlo, sin
  declarar una variable extra. Utilice un símbolo `|@|' entre el patrón a coincidir y 
  la variable a la cual asociar el valor. Este mecanismo se utiliza en el siguiente ejemplo
  para asociar el primer elemento de la lista en @l@ para mostrarlo, y al mismo tiempo asociar
  la lista completa a @ls@ para calcular su longitud:

%  Argument capture is useful for pattern-matching a value \emph{and} using it,
%  without declaring an extra variable. Use an `|@|' symbol in between the
%  pattern to match and the variable to bind the value to. This facility is
%  used below to bind the head of the list in @l@ for display, while also
%  binding the entire list to @ls@ in order to compute its length:

> len ls@(l:_) = "List starts with " ++
>   show l ++ " and is " ++
>   show (length ls) ++ " items long."
> len [] = "List is empty!"

  \sshd{Guardas}\label{function-guards}

  Las funciones booleanas se pueden utilizar como ``guardas'' en definicione de 
  función al mismo tiempo que la comparación de patrones. Un ejemplo sin comparación
  de patrones:

%  Boolean functions can be used as ``guards'' in function definitions along with
%  pattern matching. An example without pattern matching:

> which n
>   | n == 0 = "Cero"
>   | even n = "Par"
>   | otherwise = "Impar"

    Note el @otherwise@ -- siempre evalúa verdadero y puede ser utilizado para
    especificar un caso por ``default''.

%    Notice @otherwise@ -- it always evaluates to true and can be used to specify
%    a ``default'' branch.

    Las guardas se pueden utilizar con patrones. El siguiente ejemplo es una función
    que determina si el primer caracter en una cadena es mayúscula o minúscula:

%    Guards can be used with patterns. Here is a function that determines if the
%    first character in a string is upper or lower case:

> what [] = "Cadena vacía"
> what (c:_)
>   | isUpper c = "Mayúscula"
>   | isLower c = "Minúscula"
>   | otherwise = "No es letra"

  \sshd{Comparación \& Orden de las Guardas}\label{function-matching-order}

  La comparación de patrones procede en un orden de arriba hacia abajo. De la misma
  forma, las expresiones con guarda son evaluadas de la primera a la última. Por 
  ejemplo, ninguna de estas funciones sería muy interesante:

%  Pattern-matching proceeds in top to bottom order. Similarly, guard expressions
%  are tested from top to bottom. For example, neither of these functions would
%  be very interesting:

> allEmpty _ = False
> allEmpty [] = True
>
> alwaysEven n
>   | otherwise = False
>   | n `div` 2 == 0 = True

  \sshd{Sintaxis de Registros}\label{matching-record-syntax}

  Normalmente la comparación de patrones ocurre basándose en la posición en
  los argumentos del valor a coincidir. Los tipos que se declaran con 
  sintaxis de registro, sin embargo, pueden coincidir basándose en los nombres
  en el registro. Dado el siguiente tipo de datos:

%  Normally pattern matching occurs based on the position of arguments in the
%  value being matched. Types declared with record syntax, however, can match
%  based on those record names. Given this data type:

> data Color = C { red
>   , green
>   , blue :: Int }

\begin{comment}

>   deriving (Show, Eq)

\end{comment}

  \noindent podemos hacer coincidir solamente @green@:

%  \noindent we can match on @green@ only:

> isGreenZero (C { green = 0 }) = True
> isGreenZero _ = False

  Es posible capturar argumentos con esta sintaxis, aunque se vuelve incómodo. 
  Continuando con el ejemplo, podemos definir un tipo @Pixel@ y una función que
  reemplace con negro valores con componente @green@ diferente de cero: 

%  Argument capture is possible with this syntax, although it gets clunky.
%  Continuing the above, we now define a @Pixel@ type and a function to replace
%  values with non-zero @green@ components with all black:

> data Pixel = P Color

\begin{comment}

>   deriving (Show, Eq)

\end{comment}

> -- El valor del color no se 
> -- modifica si green es 0
> setGreen (P col@(C {green = 0})) = P col
> setGreen _ = P (C 0 0 0)

  \sshd{Patrones Perezosos}\label{lazy-patterns}

  Esta sintaxis, también conocida como patrones \emph{irrefutables}, permite 
  hacer comparación de patrones que siempre coincida. Esto significa que cualquier
  cláusula utilizando el patrón tendrá éxito, pero si trata de utilizar el valor
  que ha coincidido puede ocurrir un error. Esto es generalmente útil cuando se debe
  realizar una acción basándose en el \emph{tipo} de un valor en particular, aún si
  el valor no está presente.

%  This syntax, also known as \emph{irrefutable} patterns, allows pattern matches
%  which always succeed. That means any clause using the pattern will succeed,
%  but if it tries to actually use the matched value an error may occur. This is
%  generally useful when an action should be taken on the \emph{type} of a
%  particular value, even if the value isn't present.

  Por ejemplo, defina una clase para valores por default:

%  For example, define a class for default values:

> class Def a where
>   defValue :: a -> a

  La idea es que le dé a @defValue@ un valor del tipo correcto y regrese un valor
  por default para ese tipo. Definir instancias para tipos básicos es fácil:

%  The idea is you give @defValue@ a value of the right type and it gives you
%  back a default value for that type. Defining instances for basic types is
%  easy:

> instance Def Bool where
>   defValue _ = False
>
> instance Def Char where
>   defValue _ = ' '

  @Maybe@ es un poco más complicado, porque queremos obtener un valor por default
  para el tipo, pero el constructor puede ser @Nothing@. La siguiente definición
  podría funcionar, pero no es óptima porque obtenemos @Nothing@ cuando se le
  pasa @Nothing@.

%  @Maybe@ is a littler trickier, because we want to get a default value for the
%  type, but the constructor might be @Nothing@. The following definition would
%  work, but it's not optimal since we get @Nothing@ when @Nothing@ is passed in.

< instance Def a => Def (Maybe a) where
<   defValue (Just x) = Just (defValue x)
<   defValue Nothing = Nothing

  Preferiríamos mejor obtener un valor {\tt Just (\rm\emph{valor por default}\tt)\rm}.
  Aquí es donde un patrón perezoso ayuda -- podemos aparentar que hemos hecho coincidir
  con @Just x@ y usar eso para obtener un valor por default, aún si entra @Nothing@:

%  We'd rather get a {\tt Just (\rm\emph{default value}\tt)\rm} back instead.
%  Here is where a lazy pattern saves us -- we can pretend that we've matched
%  @Just x@ and use that to get a default value, even if @Nothing@ is given:

> instance Def a => Def (Maybe a) where
>   defValue ~(Just x) = Just (defValue x)

  Mientras el valor @x@ no sea evaluado, estamos a salvo. Ninguno de los tipos base
  necesita inspeccionar @x@ (ver la coincidencia con ``@_@'' que usan), así que funcionará
  bien.

%  As long as the value @x@ is not actually evaluated, we're safe. None of the
%  base types need to look at @x@ (see the ``@_@'' matches they use), so things
%  will work just fine.

  Un inconveniente con esto es que debemos proporcionar anotaciones de tipo en el intérprete
  o en el código cuando usemos un constructor @Nothing@. @Nothing@ tiene tipo @Maybe a@ pero, 
  a falta de información adicional, se debe informar a Haskell qué es @a@. Algunos ejemplos
  de valores por default:

%  One wrinkle with the above is that we must provide type annotations in the
%  interpreter or the code when using a @Nothing@ constructor. @Nothing@ has type
%  @Maybe a@ but, if not enough other information is available, Haskell must be
%  told what @a@ is. Some example default values:

> -- Return "Just False"
> defMB = defValue (Nothing :: Maybe Bool)
> -- Return "Just ' '"
> defMC = defValue (Nothing :: Maybe Char)

\shd{Listas por Comprensión}\label{list-comprehensions}

  Una lista por comprensión consiste de cuatro tipos de elementos: \emph{generadores},
  \emph{guardas}, \emph{asociaciones locales}, y \emph{objetivos}. Una lista por 
  comprensión crea una lista de valores objetivo basados en los generadores y en las
  guardas proporcionados. Esta comprensión genera todos los cuadrados:

%  A list comprehension consists of four types of elements: \emph{generators},
%  \emph{guards}, \emph{local bindings}, and \emph{targets}. A list comprehension
%  creates a list of target values based on the generators and guards given. This
%  comprehension generates all squares:

> squares = [x * x | x <- [1..]]

  @x <- [1..]@ genera una lista de todos los valores enteros positivos y los
  coloca en @x@, uno por uno. @x * x@ crea cada elemento de la lista multiplicando
  @x@ por sí mismo.

%  @x <- [1..]@ generates a list of all @Integer@ values and puts them in @x@,
%  one by one. @x * x@ creates each element of the list by multiplying @x@ by
%  itself.

  Las guardas permiten que algunos elementos sean omitidos. El ejemplo a continuación
  muestra cómo calcular los divisores (excluyendo a él mismo) para cierto número. Notar
  cómo se usa el mismo @d@ en la guarda y en la expresión objetivo.

%  Guards allow certain elements to be excluded. The following shows how divisors
%  for a given number (excluding itself) can be calculated. Notice how @d@ is
%  used in both the guard and target expression.

> divisors n =
>   [d | d <- [1..(n `div` 2)]
>      , n `mod` d == 0]

  Las asociaciones locales proveen nuevas definiciones para usar en la expresión
  generada o en las guardas y generadores que las siguen. Debajo, @z@ es empleado 
  para representar el mínimo de @a@ y @b@:

%  Local bindings provide new definitions for use in the generated expression or
%  subsequent generators and guards. Below, @z@ is used to represent the minimum
%  of @a@ and @b@:

> strange = [(a,z) | a <-[1..3]
>                  , b <-[1..3]
>                  , c <- [1..3]
>                  , let z = min a b
>                  , z < c ]

  Las comprensiones no están limitadas a números. Funcionan con cualquier lista.
  Se pueden generar todas las letras mayúsculas:

%  Comprehensions are not limited to numbers. Any list will do. All upper case
%  letters can be generated:

> ups =
>   [c | c <- [minBound .. maxBound]
>      , isUpper c]

  O, para encontrar todas las apariciones de un valor @br@ en una lista de
  palabras (con índices desde cero):

%  Or, to find all occurrences of a particular break value @br@ in a list @word@
%  (indexing from 0):

> idxs palabras br =
>   [i | (i, c) <- zip [0..] palabras
>       , c == br]

  Un aspecto único de las listas por comprensión es que los errores en la comparación 
  de patrones no causan un error; simplemente son omitidos de la lista resultante.

%  A unique feature of list comprehensions is that pattern matching failures do
%  not cause an error; they are just excluded from the resulting list.

\shd{Operadores}\label{operators}

  Hay muy pocos ``operadores'' predefinidos en Haskell---muchos que parecen estar
  predefinidos en realidad son sintaxis (e.g. ``@=@''). En lugar de eso, los 
  operadores son simplemente funciones que toman dos argumentos y tienen un 
  soporte sintáctico especial. Cualquier así llamado operador puede ser aplicado
  como una función prefijo usando paréntesis:

%  There are very few predefined ``operators'' in Haskell---most that appear
%  predefined are actually syntax (e.g., ``@=@''). Instead, operators are simply
%  functions that take two arguments and have special syntactic support. Any
%  so-called operator can be applied as a prefix function using parentheses:

< 3 + 4 == (+) 3 4

  Para definir un nuevo operador, simplemente defínalo como una función normal,
  excepto que el operador aparezca entre los dos argumentos. Este es uno que 
  inserta una coma entre dos cadenas y asegura que no aparezcan espacios 
  adicionales:

%  To define a new operator, simply define it as a normal function, except the
%  operator appears between the two arguments. Here's one which inserts a
%  comma between two strings and ensures no extra spaces appear:

> first ## last =
>   let trim s = dropWhile isSpace
>         (reverse (dropWhile isSpace
>           (reverse s)))
>   in trim last ++ ", " ++ trim first

< > "  Haskell " ## " Curry "
< Curry, Haskell

  Por supuesto, comparación de patrones, guardas, etc. están disponibles en 
  esta forma. La declaración de tipos es un poco diferentes. El operador ``nombre'' 
  debe aparecer entre paréntesis:

%  Of course, full pattern matching, guards, etc. are available in this form.
%  Type signatures are a bit different, though. The operator ``name'' must appear
%  in parentheses:

> (##) :: String -> String -> String

  Los símbolos que se permite usar para definir operadores son:

%  Allowable symbols which can be used to define operators are:

< # \$ % & * + . / < = > ? @ \ ^ | - ~

  Sin embargo, hay varios ``operadores'' que no pueden ser redefinidos. Estos
  son @<-@, @->@ y @=@. En sí mismos no se les puede asignar nueva funcionalidad,
  pero pueden ser utilizados como parte de un operador multicaracter. La función
  ``bind'', @>>=@, es un ejemplo.

%  However, there are several ``operators'' which cannot be redefined. They are:
%  @<-@, @->@ and @=@. The last, @=@, cannot be redefined by itself, but can be
%  used as part of multi-character operator. The ``bind'' function, @>>=@, is one
%  example.

  \sshd{Precedencia \& Asociatividad}\label{fixity}

  La precedencia y asociatividad, colectivamente llamadas \emph{fijidad}, de cualquier
  operador, pueden ser establecidos a través de las palabras clave @infix@, @infixr@ e
  @infixl@. Éstas pueden ser aplicadas a funciones en el nivel superior o a definiciones
  locales. La sintaxis es:

%  The precedence and associativity, collectively called \emph{fixity}, of any
%  operator can be set through the @infix@, @infixr@ and @infixl@ keywords. These
%  can be applied both to top-level functions and to local definitions. The
%  syntax is:

\bigskip
  \texttt{infix} || \texttt{infixr} || \texttt{infixl} \emph{precedencia} \emph{op}
\bigskip

  \noindent donde \emph{precedencia} varía de 0 a 9. \emph{Op} puede ser cualquier
  función que tome dos argumentos (i.e., cualquier operación binaria). Que el operador
  sea asociativo por la izquierda o por la derecha está especificado por @infixl@ o
  @infixr@, respectivamente. La declaración @infix@ no tiene asociatividad.

%  \noindent where \emph{precedence} varies from 0 to 9. \emph{Op} can actually
%  be any function which takes two arguments (i.e., any binary operation).
%  Whether the operator is left or right associative is specified by @infixl@ or
%  @infixr@, respectively. Such @infix@ declarations have no associativity.

  La precedencia y la asociatividad hacen que muchas de las reglas de la aritmética
  funcionen ``como se espera''. Por ejemplo, considere las siguientes modificaciones
  menores a la precedencia de la suma y multiplicación:

%  Precedence and associativity make many of the rules of arithmetic work ``as
%  expected.'' For example, consider these minor updates to the precedence of
%  addition and multiplication:

> infixl 8 `plus1`
> plus1 a b = a + b
> infixl 7 `mult1`
> mult1 a b = a * b

  Los resultados son sorpresivos:

%  The results are surprising:

< > 2 + 3 * 5
< 17
< > 2 `plus1` 3 `mult1` 5
< 25

  Revertir la asociatividad también tiene efectos interesantes. Redefiniendo la
  división como asociativa por la derecha:

%  Reversing associativity also has interesting effects. Redefining division as
%  right associative:

> infixr 7 `div1`
> div1 a b = a / b

  Obtenemos resultados interesantes:

%  We get interesting results:

< > 20 / 2 / 2
< 5.0
< > 20 `div1` 2 `div1` 2
< 20.0

\shd{Aplicación parcial}\label{currying}

  En Haskell las funciones no tienen que recibir todos sus argumentos de una vez.
  Por ejemplo, considere la función @convertOnly@, que solamente convierte ciertos
  elementos de una cadena dependiendo de una prueba:

% In Haskell, functions do not have to get all of their arguments at once. For
% example, consider the @convertOnly@ function, which only converts certain
% elements of string depending on a test:

> convertOnly test change str =
>     map (\c -> if test c
>                 then change c
>                 else c) str

 Usando @convertOnly@ podemos escribir la función @l33t@ que convierte ciertas
 letras a números:

% Using @convertOnly@, we can write the @l33t@ function which converts certain
% letters to numbers:

> l33t = convertOnly isL33t toL33t
>   where
>     isL33t 'o' = True
>     isL33t 'a' = True
>     -- etc.
>     isL33t _ = False
>     toL33t 'o' = '0'
>     toL33t 'a' = '4'
>     -- etc.
>     toL33t c = c

 Nótese que @l33t@ no tiene argumentos especificados. También, que el argumento
 final de @convertOnly@ no es proporcionado. Sin embargo, la declaración de tipos 
 de @l33t@ cuenta la historia completa:

% Notice that @l33t@ has no arguments specified. Also, the final argument to
% @convertOnly@ is not given. However, the type signature of @l33t@ tells the
% whole story:

< l33t :: String -> String

 Eso es, @l33t@ toma una cadena y produce una cadena. Es ``contante'' en el sentido
 de que @l33t@ siempre regresa un valos que es una función que toma una cadena y 
 produce una cadena. @l33t@ regresa una versión ``currificada'' de @convertOnly@, 
 donde solamente dos de sus tres argumentos han sido provistos.

% That is, @l33t@ takes a string and produces a string. It is a ``constant'', in
% the sense that @l33t@ always returns a value that is a function which takes a
% string and produces a string. @l33t@ returns a ``curried'' form of
% @convertOnly@, where only two of its three arguments have been supplied.

 Esto puede ser llevado más lejos. Digamos que queremos escribir una función
 que solamente cambie letras mayúsculas. Sabemos cual es la prueba a aplicar,
 @isUpper@, pero no queremos especificar la conversión. Esa función puede ser 
 escrita como:

% This can be taken further. Say we want to write a function which only changes
% upper case letters. We know the test to apply, @isUpper@, but we don't want to
% specify the conversion. That function can be written as:

> convertUpper = convertOnly isUpper

 Que tiene la declaración de tipos:

% which has the type signature:

< convertUpper :: (Char -> Char)
<   -> String -> String

 Eso es, @convertUpper@ puede tomar dos argumentos. El primero es la función de
 conversión que convierte caracteres individuales y el segundo es la cadena que
 se va a convertir.

% That is, @convertUpper@ can take two arguments. The first is the conversion
% function which converts individual characters and the second is the string to
% be converted.

 Se pueden crear una forma currificada de cualquier función que toma múltiples 
 argumentos. Una forma de pensar esto es que cada ``flecha'' en la declaración de
 tipos de la función representa una nueva función que puede ser creada al proveer
 más argumentos. 

% A curried form of any function which takes multiple arguments can be created.
% One way to think of this is that each ``arrow'' in the function's signature
% represents a new function which can be created by supplying one more argument.

 \sshd{Secciones}\label{sections}

 Los operadores son funciones, y pueden ser currificados como cualquier otro. 
 Por ejemplo, una versión currificada de ``@+@'' se puede escribir como:

% Operators are functions, and they can be curried like any other. For example, a
% curried version of ``@+@'' can be written as:

< add10 = (+) 10

 Sin embargo esto es incómodo y difícil de leer. Las ``secciones'' son operadores
 currificados, usando paréntesis. Este es @add10@ usando secciones:

% However, this can be unwieldy and hard to read. ``Sections'' are curried
% operators, using parentheses. Here is @add10@ using sections:

> add10 = (10 +)

 El argumento provisto puede estar del lado izquierdo o derecho, lo que indica qué
 posición debe tomar. Esto es importante para operaciones como la concatenación:

% The supplied argument can be on the right or left, which indicates what
% position it should take. This is important for operations such as
% concatenation:

> onLeft str = (++ str)
> onRight str = (str ++)

 Que produce resultados diferentes:

% Which produces quite different results:

< > onLeft "foo" "bar"
< "barfoo"
< > onRight "foo" "bar"
< "foobar"

\shd{``Actualizando'' Valores y la Sintaxis de Registros }\label{updating}

  Haskell es un lenguaje puro y, como tal, no tiene estado mutable. Eso es, una
  vez que un valor ha sido establecido nunca cambia. ``Actualizar'' es en realidad
  una operación de copiado, con valores nuevos en los campos que ``cambiaron''. Por
  ejemplo, usando el tipo @Color@ definido antes, podemos escribir una función que 
  establece a cero el campo @green@ fácilmente:

%  Haskell is a pure language and, as such, has no mutable state. That is, once a
%  value is set it never changes. ``Updating'' is really a copy operation, with
%  new values in the fields that ``changed.'' For example, using the @Color@ type
%  defined earlier, we can write a function that sets the @green@ field to zero
%  easily:

> noGreen1 (C r _ b) = C r 0 b

  Esto es algo extenso y puede ser vuelto a escribir con sintaxis de registro. 
  Este tipo de ``actualización'' solamente establece valores para los campos 
  especificados y copia los demás:

%  The above is a bit verbose and can be rewriten using record syntax. This kind
%  of ``update'' only sets values for the field(s) specified and copies the rest:

> noGreen2 c = c { green = 0 }

  Aquí capturamos el valor @Color@ en @c@ y devolvemos un nuevo valor @Color@. Ese
  valor resulta tener el mismo valor para @red@ y @blue@ que @c@ y su componente 
  @green@ es 0. Podemos combinar esto con comparación de patrones para establecer 
  los campos @green@ y @blue@ para que sean iguales al campo @red@:

%  Here we capture the @Color@ value in @c@ and return a new @Color@ value.  That
%  value happens to have the same value for @red@ and @blue@ as @c@ and it's
%  @green@ component is 0. We can combine this with pattern matching to set the
%  @green@ and @blue@ fields to equal the @red@ field:

> makeGrey c@(C { red = r }) =
>   c { green = r, blue = r }

  Nótese que debemos usar captura de argumentos (``|c@|'') para obtener el valor
  de @Color@ y comparar con sintaxis de registro (``|C { red = r}|'') para obtener
  el campo interno @red@.

%  Notice we must use argument capture (``|c@|'') to get the @Color@ value and
%  pattern matching with record syntax (``|C { red = r}|'') to get the inner
%  @red@ field.

\shd{Funciones Anónimas}\label{anonymous-functions}

  Una función anónima (i.e., una \emph{expresión lambda} o simplemente \emph{lambda})
  es una función sin nombre. Pueden ser definidas en cualquier momento de la
  siguiente forma:

%  An anonymous function (i.e., a \emph{lambda expression} or \emph{lambda} for
%  short), is a function without a name. They can be defined at any time like so:

< \c -> (c, c)

  que define una función que toma un argumento y regresa un tuple conteniendo ese
  argumento en ambas posiciones. Éstas son útiles para funciones simples donde no
  necesitamos un nombre. El ejemplo siguiente determina si una cadena consiste 
  solamente de letras mayúsculas o minúsculas y espacio en blanco.

%  which defines a function which takes an argument and returns a tuple
%  containing that argument in both positions. They are useful for simple
%  functions which don't need a name. The following determines if a string
%  consists only of mixed case letters and whitespace.

> mixedCase str =
>   all (\c -> isSpace c ||
>              isLower c ||
>              isUpper c) str

  Por supuesto, las lambdas pueden ser regresadas también de otras funciones. Este
  clásico regresa una función que multiplicará su argumento por el que se ha dado
  originalmente:

%  Of course, lambdas can be the returned from functions too. This classic
%  returns a function which will then multiply its argument by the one originally
%  given:

> multBy n = \m -> n * m

  Por ejemplo:

%  For example:

< > let mult10 = multBy 10
< > mult10 10
< 100

\shd{Declaración de tipos}\label{type-signatures}

  Haskell cuenta con inferencia de tipos, lo que significa que casi nunca es
  necesario declarar los tipos. Indicarlos es todavía útil al menos por dos
  razones.

%  Haskell supports full type inference, meaning in most cases no types have to
%  be written down. Type signatures are still useful for at least two reasons.

  \begin{description}
 
 \item{\emph{Documentación}}---Aún si el compilador puede inferir los tipos de
  sus funciones, otros programadore o aún usted mismo podría no ser capaz de
  hacerlo más tarde. Declarar los tipos en todas las funciones del nivel principal
  se considera una buena práctica.

% \item{\emph{Documentation}}---Even if the compiler can figure out the types
%  of your functions, other programmers or even yourself might not be able to
%  later. Writing the type signatures on all top-level functions is considered
%  very good form.

  \item{\emph{Especialización}}---Las clases de tipos permiten sobrecargar 
  funciones. Por ejemplo, una función que hace la negación de una lista de
  números tiene la declaración de tipos:

%  \item{\emph{Specialization}}---Typeclasses allow functions with overloading.
%  For example, a function to negate any list of numbers has the signature:

< negateAll :: Num a => [a] -> [a]

  Sin embargo, si por eficiencia o por otras razones solamente desea permitir
  tipos @Int@, puede hacerlo declarando los tipos:

%  However, for efficiency or other reasons you may only want to allow @Int@
%  types. You would accomplish that with a type signature:

< negateAll :: [Int] -> [Int]
  \end{description}

  Los tipos pueden aparecer en funciones del nivel superior y en definiciones
  @let@ o @where@ anidadas. En general esto es útil para hacer documentación,
  aunque en algunos casos es requerido para prevenir el polimorfismo. Una 
  declaración de tipos es primero el nombre del item, seguido de @::@, seguido de
  los tipos.  

%  Type signatures can appear on top-level functions and nested @let@ or @where@
%  definitions. Generally this is useful for documentation, although in some
%  cases they are needed to prevent polymorphism. A type signature is first the
%  name of the item which will be typed, followed by a @::@, followed by the
%  types. An example of this has already been seen above.

  Las declaraciones de tipos no necesitan aparecer directamente sobre su implementación.
  Pueden ser especificadas en cualquier parte del módulo que las contiene (aún
  debajo). Se pueden definir al mismo tiempo varios items que tengan la misma
  declaración de tipos:

%  Type signatures do not need to appear directly above their implementation.
%  They can be specified anywhere in the containing module (yes, even below!).
%  Multiple items with the same signature can also be defined together:

> pos, neg :: Int -> Int

< ...

> pos x | x < 0 = negate x
>       | otherwise = x
>
> neg y | y > 0 = negate y
>       | otherwise = y

  \sshd{Anotaciones de Tipo}\label{type-annotations}

  Algunas veces Haskell no puede determinar qué tipo se debe aplicar.
  La demostración clásica de esto es el denominado problema ``@show . read@'':

%  Sometimes Haskell cannot determine what type is meant. The classic
%  demonstration of this is the so-called ``@show . read@'' problem:

< canParseInt x = show (read x)

  Haskell no puede compilar la función porque no conoce el tipo de @read x@.
  Debemos restringir el tipo por medio de una anotación:

%  Haskell cannot compile that function because it does not know the type of @read x@.
%  We must limit the type through an annotation:

> canParseInt x = show (read x :: Int)

  Las anotaciones tienen la misma sintaxis que las declaraciones de
  tipo, pero pueden adornar cualquier expresión. Nótese que la anotación
  en el ejemplo arriba está en la expresión @read x@, no en la variable
  @x@. Solamente la aplicación de función (e.g., @read x@) asocia más 
  fuertemente que las anotaciones. Si ese no fuera el caso, habría sido
  necesario escribir @(read x) :: Int@.

%  Annotations have the same syntax as type signatures, but may adorn
%  any expression. Note that the annotation above is on the expression
%  @read x@, not on the variable @x@. Only function application (e.g.,
%  @read x@) binds tighter than annotations. If that was not the case,
%  the above would need to be written @(read x) :: Int@.

\shd{Unidad}\label{unit}

  @()@ -- tipo ``unidad'' y valor ``unidad''. El valor y tipo que no representa
  información útil.

%  @()@ -- ``unit'' type and ``unit'' value. The value and type that represents
%  no useful information.

\hd{Palabras Clave}\label{keywords}

  Las palabras clave en Haskell están listadas a continuación, en orden alfabético.

%  Haskell keywords are listed below, in alphabetical order.

\shd{Case}\label{case}

  @case@ es similar a la declaración @switch@ en C\# o Java, pero puede hacer
  comparación de un patrón: la forma del valor siendo inspeccionado. Considere un
  tipo de datos simple.

%  @case@ is similar to a @switch@ statement in C\# or Java, but can match a
%  pattern: the shape of the value being inspected.  Consider a simple data type:

> data Choices = First String | Second |
>   Third | Fourth

\begin{comment}

>   deriving (Show, Eq)

\end{comment}

  \noindent @case@ puede ser utilizado para determinar qué opción se seleccionó:

%  \noindent @case@ can be used to determine which choice was given:

> whichChoice ch =
>   case ch of
>     First _ -> "1st!"
>     Second -> "2nd!"
>     _ -> "Something else."

  Igual que en la comparación de patrones, el token `@_@' es un ``comodín'' que
  coincide con cualquier valor.

%  As with pattern-matching in function definitions, the `@_@' token is a
%  ``wildcard'' matching any value.

  \sshd{Anidado \& Captura}\label{nesting-capture}

  Se permite hacer comparación y asociación anidadas.

%  Nested matching and binding are also allowed.

\begin{figure}[H]
< data Maybe a = Just a | Nothing
\caption{La definición de @Maybe@}\label{maybe}
\end{figure}
\todo[colorize]{Change the background color or the border of this figure.}

  Usando @Maybe@ podemos determinar si alguna opción fue proporcionada utilizando
  una comparación anidada:

%  Using @Maybe@ we can determine if any choice was given using a nested match:

> anyChoice1 ch =
>   case ch of
>     Nothing -> "No choice!"
>     Just (First _) -> "First!"
>     Just Second -> "Second!"
>     _ -> "Something else."

  Se puede asociar un nombre al valor comparado para poder manipularlo:

%  Binding can be used to manipulate the value matched:

> anyChoice2 ch =
>   case ch of
>     Nothing -> "No choice!"
>     Just score@(First "gold") ->
>       "First with gold!"
>     Just score@(First _) ->
>       "First with something else: "
>         ++ show score
>     _ -> "Not first."

  \sshd{Orden de Comparación}\label{case-matching-order}

  La comparación procede de arriba hacia abajo. Si el orden de @anyChoice@ se 
  modifica de la siguiente forma, el primer patrón siempre tendrá éxito:

%  Matching proceeds from top to bottom. If @anyChoice1@ is reordered as follows,
%  the first pattern will always succeed:

> anyChoice3 ch =
>   case ch of
>     _ -> "Something else."
>     Nothing -> "No choice!"
>     Just (First _) -> "First!"
>     Just Second -> "Second!"

  \sshd{Guardas}\label{case-guards}

  Las guardas, o comparaciones condicionales, se pueden utilizar en casos igual que
  en la definición de funciones. La única diferencia es el uso de @->@ en lugar de @=@.
  Esta es una función que hace comparación de cadenas sin importar si las letras son 
  mayúscula o minúscula:

%  Guards, or conditional matches, can be used in cases just like function
%  definitions. The only difference is the use of the @->@ instead of @=@. Here
%  is a simple function which does a case-insensitive string match:

> strcmp s1 s2 = case (s1, s2) of
>   ([], []) -> True
>   (s1:ss1, s2:ss2)
>     | toUpper s1 == toUpper s2 ->
>         strcmp ss1 ss2
>     | otherwise -> False
>   _ -> False

\shd{Clases}\label{class}

  Una función en Haskell es definida para funcionar con un cierto tipo o conjunto
  de tipos y no puede ser definida más de una vez. Muchos lenguajes cuentan con el
  concepto de ``sobrecarga'', donde una función puede tener diferente comportamiento
  dependiendo del tipo de sus argumentos. Haskell implementa sobrecarga a través de
  declaraciones de @clase@ y de @instancia@. Una @clase@ define una o más funciones 
  que pueden ser aplicadas a cualquier tipo que sea miembro (i.e. instancia) de esa
  clase. Una clase es análoga a una interface en Java o C\#, y, las intancias, a una
  implementación concreta de la interface.

%  A Haskell function is defined to work on a certain type or set of types and
%  cannot be defined more than once. Most languages support the idea of
%  ``overloading'', where a function can have different behavior depending on the
%  type of its arguments. Haskell accomplishes overloading through @class@ and
%  @instance@ declarations. A @class@ defines one or more functions that can be
%  applied to any types which are members (i.e., instances) of that class. A
%  class is analogous to an interface in Java or C\#, and instances to a concrete
%  implementation of the interface.

  Una clase debe ser declarada con una o más variables de tipo. Técnicamente, Haskell
  98 solamente permite una variable de tipo, pero muchas implementaciones de Haskell
  implementan \emph{tipos de clase multi-parámetro}, que permiten más de una variable
  de tipo.

%  A class must be declared with one or more type variables. Technically, Haskell
%  98 only allows one type variable, but most implementations of Haskell support
%  so-called \emph{multi-parameter type classes}, which allow more than one type
%  variable.

  Podemos definir una clase que provee un ``sabor'' para un tipo dado:

%  We can define a class which supplies a flavor for a given type:

> class Flavor a where
>   flavor :: a -> String

  Nótese que la declaración solamente da la declaración de tipos de la función---no
  se proporciona la implementación aquí (con algunas excepciones, ver 
  \hyperref[defaults]{``Defaults''} en la página~\pageref{defaults}). Continuando,
  podemos definir varias instancias:

%  Notice that the declaration only gives the type signature of the function---no
%  implementation is given here (with some exceptions, see
%  \hyperref[defaults]{``Defaults''} on page~\pageref{defaults}). Continuing, we
%  can define several instances:

> instance Flavor Bool where
>   flavor _ = "dulce"
>
> instance Flavor Char where
>   flavor _ = "agrio"

  Evaluating @flavor True@ gives:

< > flavor True
< "dulce"

  While @flavor 'x'@ gives:

< > flavor 'x'
< "agrio"

\sshd{Defaults}\label{defaults}

  Se pueden dar implementaciones por default para las funciones en una clase. Éstas
  son útiles cuando ciertas funciones pueden ser definidas en términos de otras en 
  la clase. Un default es definido dadno un cuerpo a una de las funciones miembro. El 
  ejemplo canónico es @Eq@, que define @/=@ (no igual) en términos de @==@. :

%  Default implementations can be given for functions in a class. These are
%  useful when certain functions can be defined in terms of others in the class.
%  A default is defined by giving a body to one of the member functions. The
%  canonical example is @Eq@, which defines @/=@ (not equal) in terms of @==@. :

< class Eq a where
<   (==) :: a -> a -> Bool
<   (/=) :: a -> a -> Bool
<   (/=) a b = not (a == b)

  Se pueden crear definiciones recursivas. Continuando con el ejemplo de @Eq@, 
  @==@ puede ser definido entérminos de @/=@:

%  Recursive definitions can be created. Continuing the @Eq@ example, 
%  @==@ can be defined in terms of @/=@:

<   (==) a b = not (a /= b)

  Sin embargo, si las instancias no proveen implementaciones suficientemente
  concretas de las funciones miembro, el programa que use esas instancias
  puede entrar en ciclo infinito.

%  However, if instances do not provide enough concrete implementations
%  of member functions then any program using those instances will loop.

\shd{Data}\label{data}

  Los \emph{tipos de datos algebraicos} pueden ser declarados de la siguiente forma:
 
% So-called \emph{algebraic data types} can be declared as follows:

> data MyType = MyValue1 | MyValue2

\begin{comment}

>   deriving (Show, Eq)

\end{comment}

  @MyType@ es el \emph{nombre} del tipo. @MyValue1@ y @MyValue2@ son \emph{valores}
  del tipo y son llamados \emph{constructores}. Se pueden declarar varios constructores,
  que se separan con el caracter `@|@'. Nótese que los nombres de tipo y de constructor
  \emph{deben} iniciar con letra mayúscula. Es un error de sintaxis de cualquier otra
  forma.

%  @MyType@ is the type's \emph{name}. @MyValue1@ and @MyValue@ are \emph{values}
%  of the type and are called \emph{constructors}. Multiple constructors are
%  separated with the `@|@' character. Note that type and constructor names
%  \emph{must} start with a capital letter. It is a syntax error otherwise.

  \sshd{Constructores con Argumentos}\label{constructors-with-arguments}

  El tipo arriba noes muy interesante excepto como una enumeración. Se pueden declarar
  constructores que tomen argumentos, permitiendo que se almacene más información:

%  The type above is not very interesting except as an enumeration. Constructors
%  that take arguments can be declared, allowing more information to be stored:

> data Point = TwoD Int Int
>   | ThreeD Int Int Int

  Note que los argumentos para cada constructor son nombres de \emph{tipo}, no
  constructores. Eso significa que una declaración como la siguiente es ilegal:

%  Notice that the arguments for each constructor are \emph{type} names, not
%  constructors. That means this kind of declaration is illegal:

< data Poly = Triangle TwoD TwoD TwoD

  En lugar de eso se debe usar el tipo @Point@:

%  instead, the @Point@ type must be used:

> data Poly = Triangle Point Point Point

  \sshd{Nombres de Tipos y de Constructores}\label{type-punning}

  Los tipos y constructores pueden tener el mismo nombre, porque nunca serán
  utilizados de forma que pudiera causar conflicto. Por ejemplo:

%  Type and constructor names can be the same, because they will never be used in
%  a place that would cause confusion. For example:

> data User = User String | Admin String

  que declara un tipo llamado @User@ con dos constructores, @User@ y @Admin@. Usando
  ese tipo en una función hace clara la diferencia:

%  which declares a type named @User@ with two constructors, @User@ and @Admin@.
%  Using this type in a function makes the difference clear:

> whatUser (User _) = "normal user."
> whatUser (Admin _) = "admin user."

  Cierta literatura se refiere a esta práctica como \emph{``type punning''}.

%  Some literature refers to this practice as \emph{type punning}.

  \sshd{Variables de Tipo}\label{type-variables}

  Declarar tipos de datos \emph{polimórficos} es tan fácil como agregar variables
  de tipo en la declaración:

%  Declaring so-called \emph{polymorphic} data types is as easy as adding type
%  variables in the declaration:

> data Slot1 a = Slot1 a | Empty1

  Esto declara un tipo @Slot1@ con dos constructores, @Slot1@ y @Empty1@. El constructor
  @Slot1@ puede tomar un argumento de \emph{cualquier} tipo, que es representado por la variable
  de tipo @a@ arriba.

%  This declares a type @Slot1@ with two constructors, @Slot1@ and @Empty1@. The
%  @Slot1@ constructor can take an argument of \emph{any} type, which is
%  represented by the type variable @a@ above.

  También podemos mezclar variables de tipo y tipos específicos en los constructores:

%  We can also mix type variables and specific types in constructors:

> data Slot2 a = Slot2 a Int | Empty2

  Arriba, el constructor @Slot2@ puede tomar un valor de cualquier tipo y un valor @Int@.

%  Above, the @Slot2@ constructor can take a value of any type and an @Int@
%  value.

  \sshd{Sintaxis de Registro}\label{record-syntax}

  Se pueden declarar los argumentos del constructor ya sea por su posición, como se hace
  arriba, o utilizando sintaxis de registros, que le da un nombre a cada argumento. Por 
  ejemplo, aquí declaramos un tipo @Contact@ con nombres para los argumentos apropiados:

%  Constructor arguments can be declared either positionally, as above, or using
%  record syntax, which gives a name to each argument. For example, here we
%  declare a @Contact@ type with names for appropriate arguments:

> data Contact = Contact { ctName :: String
>       , ctEmail :: String
>       , ctPhone :: String }

  A esos nombres se les llama funciones \emph{selector} o \emph{accesor} y son
  eso, funciones. Deben empezar con minúscula o guión bajo y no pueden tener 
  el mismo nombre que otra función en el mismo contexto. Por eso el prefijo ``@ct@''
  en el ejemplo arriba. Varios constructores (del mismo tipo) pueden utilizar la
  misma función accesor para valores del mismo tipo, pero esto puede ser peligroso
  si el accesor no es utilizado por todos los constructores. Considere el siguiente
  ejemplo:

%  These names are referred to as \emph{selector} or \emph{accessor} functions
%  and are just that, functions. They must start with a lowercase letter or
%  underscore and cannot have the same name as another function in scope. Thus
%  the ``@ct@'' prefix on each above. Multiple constructors (of the same type)
%  can use the same accessor function for values of the same type, but that can
%  be dangerous if the accessor is not used by all constructors. Consider this
%  rather contrived example:

> data Con = Con { conValue :: String }
>   | Uncon { conValue :: String }
>   | Noncon
>
> whichCon con = "convalue is " ++
>   conValue con

  Si @whichCon@ es invocado con un valor @Noncon@, ocurrirá un error.

%  If @whichCon@ is called with a @Noncon@ value, a runtime error will occur.

  Finalmente, como se explica en otras partes, esos nombres se pueden utilizar
  para comparación de patrones, captura y ``actualización''.

%  Finally, as explained elsewhere, these names can be used for pattern matching,
%  argument capture and ``updating.''

  \sshd{Restricciones de Clase}\label{class-constraints}

  Se pueden declarar tipos de datos con restricciones de clase en las variables
  de tipo, pero en general esta práctica es desaprobada. Generalmente es mejor
  ocultar los constructores de datos empleando el sistema de módulos y exportar
  constructores ``inteligentes'' que apliquen las restricciones apropiadas. En
  cualquier caso, la sintaxis es:

%  Data types can be declared with class constraints on the type variables, but
%  this practice is generally discouraged. It is generally better to hide the
%  ``raw'' data constructors using the module system and instead export ``smart''
%  constructors which apply appropriate constraints. In any case, the syntax used
%  is:

> data (Num a) => SomeNumber a = Two a a
>   | Three a a a
 
 Esto declara un tipo @SomeNumber@ que tiene un argumento de variable de tipo.
 Los tipos válidos son los que están en la clase @Num@.
 
% This declares a type @SomeNumber@ which has one type variable argument. Valid
%  types are those in the @Num@ class.

  \sshd{Deriving}\label{deriving}

  Muchos tipos tienen operaciones en común que son tediosas para definir aunque
  necesarias, como la habilidad de convertir de y a cadenas, comparar igualdad, 
  u ordenar en secuencia. Esas capacidades están definidas como clases de tipos
  en Haskell.

%  Many types have common operations which are tedious to define yet necessary,
%  such as the ability to convert to and from strings, compare for equality, or
%  order in a sequence. These capabilities are defined as typeclasses in Haskell.

  Como siete de estas operaciones son muy comunes, Haskell provee la palabra clave
  @deriving@ que automáticamente implementa la clase de tipos al tipo asociado. 
  Las siete clases de tipos que permiten hacerlo son: @Eq@, @Read@, @Show@,
  @Ord@, @Enum@, @Ix@, y @Bounded@.

%  Because seven of these operations are so common, Haskell provides the
%  @deriving@ keyword which will automatically implement the typeclass on the
%  associated type. The seven supported typeclasses are: @Eq@, @Read@, @Show@,
%  @Ord@, @Enum@, @Ix@, and @Bounded@.

  Hay dos formas de usar @deriving@. La primera se utiliza cuando un tipo 
  solamente deriva una clase:

%  Two forms of @deriving@ are possible. The first is used when a type only
%  derives one class:

> data Priority = Low | Medium | High
>   deriving Show

  El segundo es usado cuando se derivan múltiples clases:

%  The second is used when multiple classes are derived:

> data Alarm = Soft | Loud | Deafening
>   deriving (Read, Show)

  Es un error de sintaxis especificar @deriving@ para ninguna otra clase
  además de las indicadas.

%  It is a syntax error to specify @deriving@ for any other classes besides the
%  six given above.

\shd{Deriving}

  Vea la sección en \hyperref[deriving]{@deriving@} bajo la palabra clave @data@
  en la página~\pageref{deriving}.

%  See the section on \hyperref[deriving]{@deriving@} under the @data@ keyword on
%  page~\pageref{deriving}.

\shd{Do}\label{do}

  La palabra clave @do@ indica que el código a continuación estará en un contexto
  \emph{monádico}. Las declaraciones están separadas por saltos de línea, la
  ``asignación'' es indicada por @<-@, y se puede emplear una forma de @let@ que
  no requiere la palabra clave @in@.

%  The @do@ keyword indicates that the code to follow will be in a \emph{monadic}
%  context. Statements are separated by newlines, assignment is indicated by
%  @<-@, and a @let@ form is introduce which does not require the @in@ keyword.

  \sshd{If con IO}\label{if-io}

  @if@ puede ser complicado cuando se utiliza con IO. Conceptualmente no es diferente
  de un @if@ en cualquier otro contexto, pero intuitivamente es difícil de asimilar.
  Considere la función @doesFileExists@ de @System.Directory@:

%  @if@ can be tricky when used with IO. Conceptually it is no different from an
%  @if@ in any other context, but intuitively it is hard to develop. Consider the
%  function @doesFileExists@ from @System.Directory@:

< doesFileExist :: FilePath -> IO Bool

  La declaración @if@ tiene esta pseudo-``declaración de tipos'':

%  The @if@ statement has this ``signature'':

< if-then-else :: Bool -> a -> a -> a

  Eso es, toma un valor @Bool@ y evalúa a algún otro valor con base en la 
  condición. De la declaración de tipos está claro que @doesFileExist@ no
  puede ser utilizado directamente por @if@:

%  That is, it takes a @Bool@ value and evaluates to some other value based on
%  the condition. From the type signatures it is clear that @doesFileExist@
%  cannot be used directly by @if@:

< wrong fileName =
<   if doesFileExist fileName
<     then ...
<     else ...

  Eso es, @doesFileExost@ resulta en un valor @IO Bool@, mientras que @if@ quiere
  un valor @Bool@. El valor correcto debe ser ``extraído'' ejecutando la acción IO:

%  That is, @doesFileExist@ results in an @IO Bool@ value, while @if@ wants a
%  @Bool@ value. Instead, the correct value must be ``extracted'' by running the
%  IO action:

> right1 fileName = do
>   exists <- doesFileExist fileName
>   if exists
>     then return 1
>     else return 0

  Note el uso de @return@. Como @do@ nos coloca ``dentro'' de la mónada @IO@, no 
  podemos ``salir''excepto a través de @return@. Nótese que no tenemos que usar @if@
  directamente aquí---también podemos usar @let@ para evaluar la condición y obtener
  un resultado primero:

%  Notice the use of @return@. Because @do@ puts us ``inside'' the @IO@ monad, we
%  can't ``get out'' except through @return@. Note that we don't have to use @if@
%  inline here---we can also use @let@ to evaluate the condition and get a value
%  first:

> right2 fileName = do
>   exists <- doesFileExist fileName
>   let result =
>         if exists
>           then 1
>           else 0
>   return result

  Una vez más, notar donde está @return@. No lo ponemos en la declaración @let@. En 
  lugar de eso lo usamos una vez al final de la función.

%  Again, notice where @return@ is. We don't put it in the @let@ statement.
%  Instead we use it once at the end of the function.

  \sshd{@do@'s Multiples}\label{multiple-dos}

  Al usar @do@ con @if@ o @case@, se requiere otro @do@ is cualquier rama tiene múltiples
  declaraciones. Un ejemplo con @if@:

%  When using @do@ with @if@ or @case@, another @do@ is required if either branch
%  has multiple statements. An example with @if@:

> countBytes1 f =
>   do
>     putStrLn "Enter a filename."
>     args <- getLine
>     if length args == 0
>       -- no 'do'.
>       then putStrLn "No filename given."
>       else
>         -- multiple statements require
>         -- a new 'do'.
>         do
>           f <- readFile args
>           putStrLn ("The file is " ++
>             show (length f)
>             ++ " bytes long.")

  Y uno con @case@:

%  And one with @case@:

> countBytes2 =
>   do
>     putStrLn "Enter a filename."
>     args <- getLine
>     case args of
>       [] -> putStrLn "No args given."
>       file -> do
>        f <- readFile file
>        putStrLn ("The file is " ++
>          show (length f)
>          ++ " bytes long.")

  Una sintaxis alternativa usa llaves y punto y coma. Todavía se requiere un @do@,
  pero la sangría es innecesaria. Este código muestra un ejemplo de @case@, pero el
  principio aplica igual con @if@:

%  An alternative syntax uses semi-colons and braces. A @do@ is still required,
%  but indention is unnecessary. This code shows a @case@ example, but the
%  principle applies to @if@ as well:

> countBytes3 =
>   do
>     putStrLn "Enter a filename."
>     args <- getLine
>     case args of
>       [] -> putStrLn "No args given."
>       file -> do { f <- readFile file;
>        putStrLn ("The file is " ++
>          show (length f)
>          ++ " bytes long."); }

\shd{Export}

  Vea la sección \hyperref[module]{@module@} en la página~\pageref{module}.

%  See the section on \hyperref[module]{@module@} on page~\pageref{module}.

\shd{If, Then, Else}\label{if}

  Recuerde, @if@ siempre ``devuelve'' un valor. Es una expresión, no solamente
  una declaración de control de flujo. Esta función revisa si la cadena dada 
  inicia con letra minúscula, y, de ser así, la convierte a mayúscula:

%  Remember, @if@ always ``returns'' a value. It is an expression, not just a
%  control flow statement. This function tests if the string given starts with a
  lower case letter and, if so, converts it to upper case:

> -- Usa comparación de patrones
> -- para obtener el primer caracter
> sentenceCase (s:rest) =
>  if isLower s
>    then toUpper s : rest
>    else s : rest
> -- Cualquier otro caso es 
> -- sobre cadena vacía
> sentenceCase _ = []

\shd{Import}

  Ver la sección \hyperref[module]{@module@} en la página~\pageref{module}.

%  See the section on \hyperref[module]{@module@} on page~\pageref{module}.

\shd{In}

  Ver \hyperref[let]{@let@} en la página~\pageref{let}.

%  See \hyperref[let]{@let@} on page~\pageref{let}.

\shd{Infix, infixl e infixr}

  Ver la sección \hyperref[operators]{operators} en la página~\pageref{operators}.

%  See the section on \hyperref[operators]{operators} on
%  page~\pageref{operators}.

\shd{Instance}

  Ver la sección \hyperref[class]{@class@} en la página~\pageref{class}.

%  See the section on \hyperref[class]{@class@} on page~\pageref{class}.

\shd{Let}\label{let}

  Se pueden definir funciones localmente dentro de una función usando @let@.
  La palabra clave @let@ debe siempre ser seguida por @in@. El @in@ debe aparecer
  en la misma columna que la palabra clave @let@. Las funciones definidas tienen
  acceso a todas las demás funciones y variables dentro del mismo contexto (incluyendo
  las definidas por @let@). En este ejemplo, @mult@ multiplica su argumento @n@ por
  @x@, que fue recibido del @multiples@ original. @mult@ es usado por @map@ para dar los
  múltiplos de x por 1 hasta 10:

%  Local functions can be defined within a function using @let@. The @let@
%  keyword must always be followed by @in@. The @in@ must appear in the same
%  column as the @let@ keyword.  Functions defined have access to all other
%  functions and variables within the same scope (including those defined by
%  @let@). In this example, @mult@ multiplies its argument @n@ by @x@, which was
%  passed to the original @multiples@. @mult@ is used by map to give the
%  multiples of x up to 10:

> multiples x =
>   let mult n = n * x
>   in map mult [1..10]

  Las ``funciones'' @let@ sin argumentos son en realidad constantes y, una vez que son
  evaluadas, no serán evaluadas otra vez. Esto es útil para capturar porciones comunes de
  su función y reutilizarlas. El siguiente es un ejemplo que da la suma de una lista de
  números, su promedio, y su mediana:

%  @let@ ``functions'' with no arguments are actually constants and, once
%  evaluated, will not evaluate again. This is useful for capturing common
%  portions of your function and re-using them. Here is a silly example which
%  gives the sum of a list of numbers, their average, and their median:

> listStats m =
>   let numbers = [1,3 .. m]
>       total = sum numbers
>       mid = head (drop (m `div` 2)
>                        numbers)
>   in "total: " ++ show total ++
>      ", mid: " ++ show mid

  \sshd{Deconstrucción}\label{deconstruction}

  El lado izquierdo de una definición @let@ puede también desestructurar su 
  argumento, en caso de que se requiera acceso a sus sub-componentes. Esta
  definición extraerá los primeros tres caracteres de una cadena:

%  The left-hand side of a @let@ definition can also destructure its argument, in
%  case sub-components are to be accessed. This definition would extract the
%  first three characters from a string

> firstThree str =
>   let (a:b:c:_) = str
>   in "Initial three characters are: " ++
>       show a ++ ", " ++
>       show b ++ ", and " ++
>       show c

  Note que esto es diferente de lo que sigue, que solamente funciona si la cadena
  tiene exactamente tres caracteres:

%  Note that this is different than the following, which only works if the string
%  has exactly three characters:

> onlyThree str =
>   let (a:b:c:[]) = str
>   in "The characters given are: " ++
>       show a ++ ", " ++ show b ++
>       ", and " ++ show c

\shd{Of}

  Vea la sección \hyperref[case]{@case@} en la página~\pageref{case}.

%  See the section on \hyperref[case]{@case@} on page~\pageref{case}.

\shd{Module}\label{module}

  Un módulo es una unidad de compilación que exporta funciones, tipos, clases,
  instancias, y otros módulos. Un módulo solamente se puede definir en un 
  solo archivo, aunque lo que exporte puede provenir de varias fuentes. Para 
  convertir un archivo Haskell en módulo basta con agregar una declaración
  de módulo hasta arriba:

%  A module is a compilation unit which exports functions, types, classes,
%  instances, and other modules. A module can only be defined in one file, though
%  its exports may come from multiple sources. To make a Haskell file a module,
%  just add a module declaration at the top:

< module MyModule where

  Los nombres de módulo deben comenzar con letra mayúscula pero pueden contener
  puntos, números y guiones bajos. Los puntos se usan para dar un sentido de
  estructura, y los compiladores Haskell los utilizarán como indicadores del
  directorio en el que está un archivo fuente en particular, pero fuera de eso
  no tienen significado.

%  Module names must start with a capital letter but otherwise can include
%  periods, numbers and underscores. Periods are used to give sense of structure,
%  and Haskell compilers will use them as indications of the directory a
%  particular source file is, but otherwise they have no meaning.

  La comunidad Haskell ha estandarizado un conjunto de nombres de módulo como @Data@,
  @System@, @Network@, etc. Asegúrese de consultarlos para seleccionar un lugar 
  apropiado para su propio módulo si planea liberarlo al público.

%  The Haskell community has standardized a set of top-level module names such as
%  @Data@, @System@, @Network@, etc. Be sure to consult them for an appropriate
%  place for your own module if you plan on releasing it to the public.

  \sshd{Import}\label{imports}

  Las bibliotecas estándar Haskell están divididas en un número de módulos. Se accede a
  la funcionalidad provista por esas bibliotecas importándolas en el programa fuente. 
  Para importar todo lo que exporta una biblioteca, simplemente use el nombre del módulo:

%  The Haskell standard libraries are divided into a number of modules. The
%  functionality provided by those libraries is accessed by importing into your
%  source file. To import everything exported by a library, just use the
%  module name:

< import Text.Read

  Todo significa \emph{todo}: funciones, tipos de datos y constructores, declaraciones
  de clase, y aún otros módulos importados y luego exportados por ese módulo. Para importar
  selectivamente se pasa una lista de nombres qué importar. Pr ejemplo, aquí importamos 
  algunas funciones de @Text.Read@:

%  Everything means \emph{everything}: functions, data types and constructors,
%  class declarations, and even other modules imported and then exported by the
%  that module. Importing selectively is accomplished by giving a list of names
%  to import. For example, here we import some functions from @Text.Read@:

< import Text.Read (readParen, lex)

  Los tipos de datos pueden ser importados de varias formas. Podemos solamente
  importar el tipo sin constructores:

%  Data types can imported in a number of ways. We can just import the type and
%  no constructors:

< import Text.Read (Lexeme)

  Por supuesto, esto impide que nuestro módulo haga comparación de patrones con
  los valores de tipo @Lexeme@. Podemos importar uno o más constructores explícitamente:

%  Of course, this prevents our module from pattern-matching on the values of
%  type @Lexeme@. We can import one or more constructors explicitly:

< import Text.Read (Lexeme(Ident, Symbol))

  Se pueden importar todos los constructores para un tipo dado:

%  All constructors for a given type can also be imported:

< import Text.Read (Lexeme(..))

  Podemos también importar tipos y clases definidos en el módulo:

%  We can also import types and classes defined in the module:

< import Text.Read (Read, ReadS)

  En el caso de las clases, podemos importar las funciones definidas para una 
  clase usando una sintaxis similar a importar constructores para tipos de datos:

%  In the case of classes, we can import the functions defined for a class using
%  syntax similar to importing constructors for data types:

< import Text.Read (Read(readsPrec
<                       , readList))

  Note que, a diferencia de los tipos de datos, todas las funciones de clase son
  importadas a menos que sean explícitamente excluídas. Para importar \emph{sólo}
  las clases, usamos esta sintaxis:

%  Note that, unlike data types, all class functions are imported unless
%  explicitly excluded. To \emph{only} import the class, we use this syntax:

< import Text.Read (Read())

  \sshd{Exclusiones}\label{exclusions}

  Si la mayoría, pero no todos los nombres van a ser importados de un módulo,
  sería tedioso listarlos. Por esa razón, también se pueden omitir nombres con
  la palabra clave @hiding@ (``ocultar''):

%  If most, but not all, names are to be imported from a module, it would be
%  tedious to list them all. For that reason, imports can also be specified via
%  the @hiding@ keyword:

< import Data.Char hiding (isControl
<                         , isMark)

  Excepto por las declaraciones de instancia, cualquier tipo, función o clase
  pueden ser ocultos.

%  Except for instance declarations, any type, function, constructor or class can
%  be hidden.

  \sshd{Declaraciones de Instancia}\label{instance-declarations}

  Debe notarse que las declaraciones de instancia (@instance@) \emph{no pueden}
  ser excluídas al importar; todas las declaraciones @instance@ en un módulo serán
  importadas cuando el módulo sea importado.

%  It must be noted that @instance@ declarations \emph{cannot} be excluded from
%  import: all @instance@ declarations in a module will be imported when the
%  module is imported.

  \sshd{Import Qualified}\label{qualified-imports}

  Los nombres exportados por un módulo (i.e., funciones, tipos, operadores, etc.)
  pueden tienen un prefijo asociado a través de importación calificada. Esto es
  particularmente útil para módulos que tienen un gran número de funciones con el 
  mismo nombre que funciones del @Prelude@. @Data.Set@ es un buen ejemplo:

%  The names exported by a module (i.e., functions, types, operators, etc.) can
%  have a prefix attached through qualified imports. This is particularly useful
%  for modules which have a large number of functions having the same name as
%  @Prelude@ functions. @Data.Set@ is a good example:

< import qualified Data.Set as Set

  Esta forma requiere que cualquier función, tipo, constructor u otro nombre 
  exportado por @Data.Set@ tenga el prefijo del \em{alias} dado (i.e., @Set@).
  La siguiente es una forma de remover todos los duplicados de una lista:

%  This form requires any function, type, constructor or other name exported by
%  @Data.Set@ to now be prefixed with the \emph{alias} (i.e., @Set@) given. Here
%  is one way to remove all duplicates from a list:

> removeDups a =
>   Set.toList (Set.fromList a)

  Una segunda forma no crea un alias. En lugar de ello, el prefijo se convierte
  en el nombre del módulo. Podemos escribir una función que verifique si una
  cadena está escrita en todo mayúsculas:

%  A second form does not create an alias. Instead, the prefix becomes the module
%  name. We can write a simple function to check if a string is all upper case:

< import qualified Char

> allUpper str =
>   all Char.isUpper str

  Excepto por el prefijo especificado, la importación calificada emplea la misma 
  sintaxis que una importación normal. Los nombres importados se pueden limitar de 
  las mismas formas descritas arriba.

%  Except for the prefix specified, qualified imports support the same syntax as
%  normal imports. The name imported can be limited in the same ways as described
%  above.

  \sshd{Export}\label{exports}

  Si no se provee una lista de exportaciones, entonces todas las funciones, tipos,
  constructores, etc. estarán disponibles siempre que se importe el módulo. Note 
  que los módulos importados \emph{no} son exportados en este caso. Limitar los
  nombres exportados se consigue agregando una lista entre paréntesis de los nombres
  antes de la palabra clave @where@:

%  If an export list is not provided, then all functions, types, constructors,
%  etc. will be available to anyone importing the module. Note that any imported
%  modules are \emph{not} exported in this case. Limiting the names exported is
%  accomplished by adding a parenthesized list of names before the @where@
%  keyword:

< module MyModule (MyType
<   , MyClass
<   , myFunc1
<   ...)
< where

  La misma sintaxis que se usa para importar puede ser usada para especificar
  qué funciones, tipos, constructores, y clases son exportados, con unas pocas
  diferencias. Si un módulo importa otro módulo, puede también exportar ese
  módulo:

%  The same syntax as used for importing can be used here to specify which
%  functions, types, constructors, and classes are exported, with a few
%  differences. If a module imports another module, it can also export that
%  module:

< module MyBigModule (module Data.Set
<   , module Data.Char)
< where
<
< import Data.Set
< import Data.Char

  Un módulo puede también re-exportarse a sí mismo, lo que puede ser útil cuando
  todas las definiciones locales y un módulo importado dado van a se exportados. 
  A continuación nos exportamos a nosotros mismos y a @Data.Set@, pero no a @Data.Char@:

%  A module can even re-export itself, which can be useful when all local
%  definitions and a given imported module are to be exported. Below we export
%  ourselves and @Data.Set@, but not @Data.Char@:

< module AnotherBigModule (module Data.Set
<   , module AnotherBigModule)
< where
<
< import Data.Set
< import Data.Char

\shd{Newtype}\label{newtype}

  Mientras que @data@ agrega nuevos valores y @type@ solamente crea sinónimos, 
  @newtype@ está en un punto medio. La sintaxis para @newtype@ está más 
  restringida---solamente se puede definir un constructor, y ese constructor 
  solamente puede tomar un argumento. Continuando con el ejemplo de arriba, 
  podemos definir un tipo @Phone@ de la forma que sigue:

%  While @data@ introduces new values and @type@ just creates synonyms, @newtype@
%  falls somewhere between. The syntax for @newtype@ is quite restricted---only
%  one constructor can be defined, and that constructor can only take one
%  argument. Continuing the above example, we can define a @Phone@ type as
%  follows:

> newtype Home = H String
> newtype Work = W String
> data Phone = Phone Home Work

\todo[use lowerName?]{lowerName function from above?}

  En contraste con @type@, los ``valores'' @H@ y @W@ en @Phone@ \emph{no} son
  solamente valores @String@. El verificador de tipos los trata como tipos
  completamente nuevos. Eso significa que nuestra función @lowerName@ arriba
  no compilaría. Esto produce un error de tipos:

%  As opposed to @type@, the @H@ and @W@ ``values'' on @Phone@ are \emph{not}
%  just @String@ values. The typechecker treats them as entirely new types. That
%  means our @lowerName@ function from above would not compile. The following
%  produces a type error:

< lPhone (Phone hm wk) =
<   Phone (lower hm) (lower wk)

  En lugar de eso, debemos usar comparación de patrones para llegar a los ``valores''
  a los que queremos aplicar @lower@:

%  Instead, we must use pattern-matching to get to the ``values'' to which we
%  apply @lower@:

> lPhone (Phone (H hm) (W wk)) =
>   Phone (H (lower hm)) (W (lower wk))

  La observación clave es que esta palabra clave no crea un valor nuevo; en lugar
  de eso crea un tipo nuevo. Esto proporciona dos propiedades muy útiles:

%  The key observation is that this keyword does not introduce a new value;
%  instead it introduces a new type. This gives us two very useful properties:

  \begin{compactitem}
 
  \item No hay costo en tiempo de ejecución asociado al tipo nuevo, porque en
  realidad no produce valores nuevos. En otras palabras, @newtype@ es absolutamente
  gratis en desempeño cuando el programa es ejecutado.

%  \item No runtime cost is associated with the new type, since it does not
%  actually produce new values. In other words, newtypes are absolutely free!

  \item El verificador de tipos puede hacer que tipos comunes como @Int@ o 
  @String@ se usen de formas restringidas, especificadas por el programador.

%  \item The type-checker is able to enforce that common types such as @Int@ or
%  @String@ are used in restricted ways, specified by the programmer.

  \end{compactitem}

  Finalmente, se debe notar que cualquier cláusula @deriving@ que puede ser 
  anexada a una declaración @data@ puede también ser usada al declarar un 
  @newtype@.

%  Finally, it should be noted that any @deriving@ clause which can be attached
%  to a @data@ declaration can also be used when declaring a @newtype@.

\shd{Return}

  Ver \hyperref[do]{@do@} en la página~\pageref{do}.

%  See \hyperref[do]{@do@} on page~\pageref{do}.

\shd{Type}\label{type}

  Esta palabra clave define un \emph{sinónimo de tipo} (i.e., alias). Esta
  palabra clave no define un tipo nuevo, como @data@ o @newtype@. Es útil para 
  documentar código pero, además de eso, no tiene efecto en el tipo de una 
  función o valor dados. Por ejemplo, un tipo de datos @Person@ puede ser 
  definido como:

%  This keyword defines a \emph{type synonym} (i.e., alias). This keyword does
%  not define a new type, like @data@ or @newtype@. It is useful for documenting
%  code but otherwise has no effect on the actual type of a given function or
%  value. For example, a @Person@ data type could be defined as:

<  data Person = Person String String

  donde el argumento del primer constructor representa al nombre y el segundo al
  apellido. Sin embargo, el orden y significado de los dos argumentos no es muy
  claro. Una declaración con @type@ puede ayudar:

%  where the first constructor argument represents their first name and the
%  second their last. However, the order and meaning of the two arguments is not
%  very clear. A @type@ declaration can help:

> type FirstName = String
> type LastName = String
> data Person = Person FirstName LastName

  Como @type@ crea un sinónimo, la verificación de tipos no se afecta. La función
  @lower@, definida como:

%  Because @type@ introduces a synonym, type checking is not affected in any way.
%  The function @lower@, defined as:

> lower s = map toLower s

  que tiene tipo

%  which has the type

< lower :: String -> String

  puede ser usada igual en valores con tipo @FirstName@ o @LastName@:

%  can be used on values with the type @FirstName@ or @LastName@ just as easily:

> lName (Person f l ) =
>   Person (lower f) (lower l)

  Como @type@ es solamente un sinónimo, no puede declarar múltiples constructores
  de la forma que @data@ puede. Se pueden usar variables de tipo, pero no puede haber
  más que las las variables de tipo declaradas con el tipo original. Eso significa que
  un sinónimo como el siguiente es válido:

%  Because @type@ is just a synonym, it cannot declare multiple constructors the
%  way @data@ can. Type variables can be used, but there cannot be more than the
%  type variables declared with the original type. That means a synonym like the
%  following is possible:

< type NotSure a = Maybe a

  pero este no:

%  but this not:

< type NotSure a b = Maybe a

  Nótese que se pueden usar \emph{menos} variables de tipo, lo que es útil en
  ciertas circunstancias.

%  Note that \emph{fewer} type variables can be used, which useful in certain
%  instances.

\shd{Where}\label{where}

  De la misma forma que @let@, @where@ define funciones y constantes locales. El
  contexto de una definición @where@ es la función actual. Si una función está
  dividida en definiciones múltiples con comparación de patrones, entonces el
  contexto de una cláusula @where@ en particular solamente aplica a esa definición.
  Por ejemplo, la función @result@ a continuación tiene un significado diferente
  dependiendo de los argumentos proporcionados a la función @strlen@:

%  Similar to @let@, @where@ defines local functions and constants. The scope of
%  a @where@ definition is the current function. If a function is broken into
%  multiple definitions through pattern-matching, then the scope of a particular
%  @where@ clause only applies to that definition. For example, the function
%  @result@ below has a different meaning depending on the arguments given to the
%  function @strlen@:

> strlen [] = result
>   where result = "No string given!"
> strlen f = result ++ " characters long!"
>   where result = show (length f)

  \sshd{Where vs. Let}\label{where-vs-let}

  Una cláusula @where@ solamente puede ser definida al nivel de una definición de
  función. Usualmente, eso es idéntico al contexto de una definición @let@. La 
  única diferencia es en cuándo son utilizadas las guardas. En contraste, el
  contexto de una expresión @let@ es solamente la cláusula actual de la función 
  \emph{y} la guarda, de existir.

%  A @where@ clause can only be defined at the level of a function definition.
%  Usually, that is identical to the scope of @let@ definition. The only
%  difference is when guards are being used. The scope of the @where@ clause
%  extends over all guards. In contrast, the scope of a @let@ expression is only
%  the current function clause \emph{and} guard, if any.

\hd{Traducción al Español}\label{translatees}

 Jaime Soffer, jaime.soffer@@gmail.com

\hd{Contributors}\label{contributors}

  My thanks to those who contributed patches and useful suggestions:
  Dave Bayer, Paul Butler, Elisa Firth, Marc Fontaine, Cale Gibbard,
  Stephen Hicks, Kurt Hutchinson, Johan Kiviniemi, Adrian Neumann,
  Barak Pearlmutter, Lanny Ripple, Markus Roberts, Holger Siegel, Adam
  Vogt, Leif Warner, and Jeff Zaroyko.

\hd{Version}\label{version}

  This is version 2.0. The source can be found at GitHub
  (\url{http://github.com/m4dc4p/cheatsheet}). The latest released
  version of the PDF can be downloaded from
  \url{http://cheatsheet.codeslower.com}.  Visit CodeSlower.com
  (\url{http://blog.codeslower.com/}) for other projects and writings.

 Traducción al Español version 0.01 sobre la versión original mencionada
 arriba. Repositorio en http://github.com/jsoffer/cheatsheet

\todos
\end{multicols}
\end{document}

% vim:set tw=80:
