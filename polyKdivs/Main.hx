package;

// use Divtastic3 for this test.
import js.Browser;
import core.SetupCanvas;
import js.html.Element;
import core.DisplayDiv;
import js.html.DivElement;
import core.DivDrawing;
import core.GlobalDiv;
import hxPolyK.PolyK;
import js.html.CanvasRenderingContext2D;
import core.CSSenterFrame;
using core.GlobalDiv;
using core.DivDrawing;
using Main;
typedef Point = {
    var x: Float;
    var y: Float;
}
typedef AccessEnterFrame = {
    public var onEnterFrame: Void -> Void;
}
class Main{
    
    var holder: DisplayDiv;
    var lineHolder: DisplayDiv;
    var surface: CanvasRenderingContext2D;
    var poly = [ 93., 195., 129., 92., 280., 81., 402., 134., 477., 70., 619., 61., 759., 97., 758., 247., 662., 347., 665., 230., 721., 140., 607., 117., 472., 171., 580., 178., 603., 257., 605., 377., 690., 404., 787., 328., 786., 480., 617., 510., 611., 439., 544., 400., 529., 291., 509., 218., 400., 358., 489., 402., 425., 479., 268., 464., 341., 338., 393., 427., 373., 284., 429., 197., 301., 150., 296., 245., 252., 384., 118., 360., 190., 272., 244., 165., 81., 259., 40., 216.];
    var count = 0;
    var enterFrame: CSSenterFrame;
    var lines: List<List<DivElement>>;
    var lineCol = '#f0f0bf';
    var lineThick = 3;
    var circles = new List<DisplayDiv>();
    static inline var diaX: Int = 18;
    static inline var diaY: Int = 20;
    
    static function main(){ new Main(); } public function new(){
        var setup = new SetupCanvas();
        surface = setup.surface;
        var body = Browser.document.body;
        body.appendChild( setup.dom );
        holder =  new DisplayDiv();
        holder.x = 100 ;
        holder.y = 50 ;
        holder.width = 800 ;
        holder.height = 600 ;
        addChild( holder ) ;
        lineHolder = new DisplayDiv();
        lineHolder.x = 0;
        lineHolder.y = 0;
        holder.addChild( lineHolder );
        createVertices( poly );
        drawTriangulationLines( poly );
        enterFrame = new CSSenterFrame( triangulateMaybe );
    }
    
    function triangulateMaybe():Void {
        count++;
        if( dragging && count%3 == 0 ) renderTriangulation();
    }
    
    function killEnterFrame() {
        var ef: AccessEnterFrame = cast enterFrame;
        ef.onEnterFrame = null;
    }
    
    function createVertices( poly_: Array<Float> ){
        var polyPairs = new ArrayPairs( poly_ );
        var col = rainbowPencilColors();
        var len = col.length;
        var rainbowId = 0;
        var rx = diaX/2;
        var ry = diaY/2;
        var circle: DisplayDiv;
        for( p in polyPairs ){
            circle = createCircle( Std.int( p.x - rx ), Std.int( p.y - ry ), col[ rainbowId%len ] );
            circle.setupDrag();
            circle.dragInform = true;
            circle.dragging.add( update );
            circle.release.add( finish );
            rainbowId++;
            circles.push( circle );
        }
    }
    
    var dragging: Bool = false;
    
    function update(){
        dragging = true;
    }
    
    function finish(){
        dragging = false;
        renderTriangulation();
    }
    
    function renderTriangulation(){
        poly = new Array<Float>();
        var rx = diaX/2;
        var ry = diaY/2;
        var circle: DisplayDiv;
        for( circle in circles ){
            poly.push( circle.y + ry );
            poly.push( circle.x + rx );
        }
        poly.reverse();
        drawTriangulationLines( poly );
    }
    
    function drawTriangulationLines( poly_: Array<Float> ){
        clear();
        var tgs = PolyK.triangulate( poly_ ); 
        var triples = new ArrayTriple( tgs );
        var a: Point;
        var b: Point;
        var c: Point;
        var i: Int;
        var points: Array<Float>;
        var temp = new List();
        for( tri in triples ){
            i = Std.int( tri.a*2 );
            a = { x: poly[ i ], y: poly[ i + 1 ] };
            i = Std.int( tri.b*2 );
            b = { x: poly[ i ], y: poly[ i + 1 ] };
            i = Std.int( tri.c*2 );
            c = { x: poly[ i ], y: poly[ i + 1 ] };
            temp.add( lineHolder.lineFromTo( a.x, a.y, b.x, b.y, lineThick, lineThick, lineCol ) );
            temp.add( lineHolder.lineFromTo( b.x, b.y, c.x, c.y, lineThick, lineThick, lineCol ) );
            temp.add( lineHolder.lineFromTo( c.x, c.y, a.x, a.y, lineThick, lineThick, lineCol ) );
        }
        lines = temp;
    }
    
    function createCircle( x: Int, y: Int, col: Int ): DisplayDiv {
        var circle = new DisplayDiv() ;
        circle.x = x;
        circle.y = y;
        var divs = circle.drawGradElipse( 0, 0, diaX, diaY, col, col );
        holder.addChild( circle );
        return circle;
    }
    
    function clear(){
        if( lines != null ){
            for( i in lines ){
                for( j in i ){
                    lineHolder.getInstance().removeChild( j );
                }
                i = null;
            }
        }
    }
    
    static inline function rainbowPencilColors(){ return [   0xD2D0C1
                                                            ,   0xCD8028
                                                            ,   0xD29D11
                                                            ,   0xE37128
                                                            ,   0xF06771
                                                            ,   0xD23931
                                                            ,   0xAF2C31
                                                            ,   0x90333E
                                                            ,   0x863D50
                                                            ,   0x584A5D
                                                            ,   0x549EC3
                                                            ,   0x2C709D
                                                            ,   0x457AAE
                                                            ,   0x364D6D
                                                            ,   0x378C6D
                                                            ,   0x6EA748
                                                            ,   0x365DA4
                                                            ,   0x456E42
                                                            ,   0xC1882E
                                                            ,   0x813424
                                                            ,   0x402E24
                                                            ,   0x292420
                                                            ,   0x525751
                                                            ,   0x1B1B19
                                                            ]; }
}
