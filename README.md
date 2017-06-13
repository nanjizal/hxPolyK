# hxPolyK
Haxe port of PolyK javascript library. To cross target solution.

Some additonal abstracts have been added these can make looping through to construct the triangles easier.

Triangulate approach

```
    public function polykTest(){
        var poly = [ 93., 195., 129., 92., 280., 81., 402., 134., 477., 70., 619., 61., 759., 97., 758., 247., 662., 347., 665., 230., 721., 140., 607., 117., 472., 171., 580., 178., 603., 257., 605., 377., 690., 404., 787., 328., 786., 480., 617., 510., 611., 439., 544., 400., 529., 291., 509., 218., 400., 358., 489., 402., 425., 479., 268., 464., 341., 338., 393., 427., 373., 284., 429., 197., 301., 150., 296., 245., 252., 384., 118., 360., 190., 272., 244., 165., 81., 259., 40., 216.];
        var tgs = PolyK.triangulate( poly ); 
        var triples = new ArrayTriple( tgs );
        var a: Point;
        var b: Point;
        var c: Point;
        var i: Int;
        for( tri in triples ){
            i = Std.int( tri.a*2 );
            a = { x: poly[ i ], y: poly[ i + 1 ] };
            i = Std.int( tri.b*2 );
            b = { x: poly[ i ], y: poly[ i + 1 ] };
            i = Std.int( tri.c*2 );
            c = { x: poly[ i ], y: poly[ i + 1 ] };
            TwoLines.drawTri( a, b, c, 0xff0000, 0xffffff, 0, 0 );
        }
    }
```  
