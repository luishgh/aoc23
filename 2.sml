val maxRed = 12
val maxGreen = 13
val maxBlue = 14

fun requiredCubes [] red green blue = (red, green, blue)
  | requiredCubes (word::[]) red green blue = (red, green, blue)
  | requiredCubes (word::words) red green blue = 
    let val maybeInt = Int.fromString word
        val nextWord = hd words
    in
      case maybeInt of 
           NONE => requiredCubes words red green blue
         | (SOME x) => case nextWord of
                           "red" => requiredCubes words (red + x) green blue
                          | "green" => requiredCubes words red (green + x) blue
                          | "blue" => requiredCubes words red green (blue + x)
                          | _ => requiredCubes words red green blue
    end
                          
fun maxTuple ((a1, b1, c1), (a2, b2, c2)) =
  (Int.max(a1, a2), Int.max(b1, b2), Int.max(c1, c2))

fun parseGame game = 
let 
  val shows = String.tokens (fn c => c = #";") game
  fun no_punct([]) = []
    | no_punct(c::res) = if (c = #";" orelse c = #"," orelse c = #":") 
                          then no_punct(res) 
                          else c::no_punct(res)
  val words = map (String.tokens Char.isSpace) shows
  val parsed_shows = map 
  (map (fn s => implode(no_punct(explode s)))) words
  val (SOME id) = Int.fromString (List.nth ((hd parsed_shows), 1))
  val cubes = map (fn words => requiredCubes words 0 0 0) parsed_shows
in
  (id, List.foldl maxTuple (hd cubes) (tl cubes))
end


fun readInput () = 
let val file = TextIO.openIn "2.in"
    val content = TextIO.inputAll file
    val _ = TextIO.closeIn file
in String.tokens (fn c => c = #"\n") content
end

val input = readInput ()
val games = map parseGame input

(* Part 1 *)
val validGames = List.filter 
  (fn (_, (red, green, blue)) => 
  red <= maxRed andalso 
  green <= maxGreen andalso 
  blue <= maxBlue) games
val ans = List.foldl (fn ((id, _), acc) => acc + id) 0 validGames
val _ = print (Int.toString ans ^ "\n")

(* Part 2 *)
val powers = map (fn (_, (red, green, blue)) => red * green * blue) games
val ans = List.foldl op+ 0 powers
val _ = print (Int.toString ans ^ "\n")
