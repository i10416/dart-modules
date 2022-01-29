# flechette

lightweight dart extensions.


## flechette/struct

Result: `Result<T>`

```dart
final success = Result.success(1);
final failure = Result<T>.failure('error key','error message');
success.isSuccess // => true;
failure.isSuccess // => false;
success.map((s)=>s*2); // => Result.success(2);
success.flatMap((s) => Result.success('100') )// => Result.success('100');
success.flatMap((s) => Result.failure(...)) // => Result.failure(...);
```

Tuple: `$(a,b)` 

```dart
final tpl = $(1,'a'); // create tuple
tpl.$0 // => 1
tpl.$1 // => 'a'
tpl.swap(); // =>  $('a',1);
tpl.mapN((l,r) => T  ); // => T
```


## flechette/syntax

Collection/Iterable

```dart
final l = [1,2,3,4,5];
l.zipWithIndex // => [(1,0),(2,1),(3,2),(4,3),(5,4)]
l.slide // => [(1,2),(2,3),(3,4),(4,5)]
l.zip(['a','b','c','d','e']); // => [(1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e')]
l.intersect(-1) // => [1,-1,2,-1,3,-1,4,-1,5];
```


Collection/Map

```dart
final map = {'a':1,'b':2,'c':3};
map.updateWith(key)((v) => v == null ? 'newItem' : '$v already exists');
```

Optional

```dart
final T? t = ???;
t
    .map((a)=>  b)
    .filter((b)=> cond(b) )
    .getOrElse(()=>els);


const int? a = 1;
const int? b = null;

a.fold(() => 'none!')((e) => (e * 100).toString()); // => '100'
b.fold(() => 'none!')((e) => (e * 100).toString()); // => 'none!'
```

dart/core

```dart
DateTimeX.attemptParse('...'); // => Result<DateTime>
UriX.attemptParse('...'); // => Result<DateTime>
```