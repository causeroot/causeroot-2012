d3.csv("/graphs.csv", createSvgElements);

function createSvgElements(data) {
    data.sort(function(a,b) {return b.Cost - a.Cost;});

    var theDomIsStupid = 'o'; // Prefix for DOM entities

    var margin = {top: 1, right: 1, bottom: 1, left: 1};
    width = 580;
    height = 320;
    scaleFactor = Math.sqrt(width*width + height*height);

    var x = pad(d3.scale.linear()
        .domain(d3.extent(data, function(d) { return xval(d); }))
        .range([0, width - margin.left - margin.right]), scaleFactor*0.030);

    var y = pad(d3.scale.linear()
        .domain(d3.extent(data, function(d) { return yval(d); }))
        .range([height - margin.top - margin.bottom, 0]), scaleFactor*0.030);

    var halfHeight = y(-0.1),
        halfWidth = x(-0.1);

    var canvas = d3.select("body").append("svg")
        .attr("width", width)
        .attr("height", height)
        .attr("class", "dot chart")
        .append("g");
    var svg = canvas.append("g")
        .attr('class', 'bckg')
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var axisColor = '#AAAAAA';

    var xLine = svg.append("svg:line")
        .attr("class", "line")
        .attr("id", "xline")
        .attr("x1", 0)
        .attr("y1", halfHeight)
        .attr("x2", width)
        .attr("y2", halfHeight)
        .attr("stroke", axisColor);

    var yLine = svg.append("svg:line")
        .attr("class", "line")
        .attr("id", "xline")
        .attr("x1", halfWidth)
        .attr("y1", 0)
        .attr("x2", halfWidth)
        .attr("y2", height)
        .attr("stroke", axisColor);

    var g = svg.append("g").attr("class", "circles").selectAll("circles")
        .data(data)
        .enter().append("svg:g")
        .attr("class", "c");

    var g2 = svg.append("g").attr("class", "text").selectAll("text")
        .data(data)
        .enter().append("svg:g")
        .attr("class", "c");

// Text for individual problem data points
    var txt = g2.append("svg:text")
        .attr("class", "nodeText")
        .attr("id", function(d){return idFunc(d)+'t';})
        .attr("x", function(d) {return x(xval(d));})
        .attr("y", function(d) {return y(yval(d));})
        .attr("dx", function(d) {return 0.75*rad(d);})
        .attr("dy", function(d) {return -0.75*rad(d);})
        .text(function(d) {return d['Problem Name'];})
        .attr("visibility", "hidden")
        .attr('dy', fixDYValue)
        .attr('dy', fixYDYValue)
        .attr('x', fixXValue);

// Problem data points represented as circles
    var circles = g.append("svg:circle")
        .attr("class", "dot")
        .attr("id", idFunc)
        .attr("cx", function(d) { return x(xval(d)); })
        .attr("cy", function(d) { return y(yval(d)); })
        .attr("r", function(d) { return rad(d); })
        .attr("fill", function(d) { return cinterp(d.Complexity);})
        .on("mouseover", function(){
            d3.select(".text").select('#'+this.id+'t')
                .attr("visibility","visible");})
        .on("mouseout", function(){
            d3.select(".text").select('#'+this.id+'t')
                .attr("visibility","hidden");});

    //createButton(canvas);
    createLegend(canvas);

    function idFunc(d) {
        return theDomIsStupid+hash(d['Problem Name']);
    }

    var mouseOverFunction = function () {
        var c = d3.select(this);
    };

    function textLength(obj) {
        return parseInt(d3.select('#' + obj.id)[0][0].getComputedTextLength());
    }

    function centerY() {
        return (height-textLength(this))/2;
    }

    function centerX() {
        return (width-textLength(this))/2;
    }

    function xValueOffset(obj) {
        var rightPadding = 10;
        var textWidth = textLength(obj) + margin.left +
            parseInt(obj.getAttribute('dx')) + rightPadding; // additions due to padding and shift.
        var textX = parseInt(obj.getAttribute('x'));
        var textEnd = textX + textWidth;
        return Math.max(0, textEnd - width);
    }


    function fixXValue() {
        var textX = parseInt(this.getAttribute('x'));
        return textX - xValueOffset(this);
    }

    function fixYDYValue() {
        var textY = parseInt(this.getAttribute('y'));
        var textDY = parseInt(this.getAttribute('dy'));
        var boxHeight = this.getBBox().height;
        return (textY+textDY-boxHeight >= 0) ? textDY : textY - boxHeight;
    }

    function fixDYValue() {
        var textDY = parseInt(this.getAttribute('dy'));
        if (xValueOffset(this)) {
            return textDY * 1.4;
        }
        return textDY;
    }

    function createLegend(svg) {
        var legend = svg.append('g')
            .attr('class', 'nodeText light');

        var legendX = legend.append("svg:text").attr('x', width/2)
            .attr('y', '' + (height - 5))
            .attr('id','legendX')
            .attr('text-anchor','middle')
            .text('IMPORTANCE');

        var legendY = legend.append("svg:text")
            .text('IMMEDIACY').attr('id', 'legendY')
            .attr('text-anchor', 'middle')
            .attr('transform', 'rotate(-90)')
            .attr('x', -height/2);
        legendY.attr('y', document.getElementById('legendY').getBBox().height *.85);

        /*var legendS = legend.append("svg:text")
         .text('Size: ')
         .attr('dy', '45');
         textAppend(legendS, 'Cost');

         var legendC = legend.append('svg:text')
         .text('Color: ')
         .attr('dy', '60');
         textAppend(legendC, 'Cost');

         function textAppend(obj, txt) {
         obj.append('tspan').text(txt).attr('class', 'legend nodeText light');
         }*/
    }

    function createButton(svg) {
        var button = svg.append('g')
            .append('svg:rect')
            .attr('x', width*0.96)
            .attr('y', height*0.96)
            .attr('width', scaleFactor*0.02)
            .attr('height', scaleFactor*0.02)
            .attr('r', 10)
            .attr('fill', '#3311FF')
            .on("mouseover", function(){
                d3.select(this).transition().style("fill", "#FF0000");
            })
            .on('mouseout', function() {
                d3.select(this).transition().style("fill", "#00FF00");
            });
    }

    function pad(scale, k) {
        var range = scale.range();
        if (range[0] > range[1]) k *= -1;
        return scale.domain([range[0] - k, range[1] + k].map(scale.invert)).nice();
    }
}

/* This path interpolates along any path in color space smoothly!*/
function cinterp (t) {
    var cl = ['#2FBF19', '#737223', '#F2C449', '#7A4520', '#CC322D'];
    var idx = Math.floor(t * (cl.length-1));
    if (idx >= (cl.length-1)) {
        return cl[cl.length-1];
    }
    if (idx <= 0) {
        return cl[0];
    }
    return d3.interpolateHsl(cl[idx],cl[idx+1])(t);
}

function xval(d) { return d.Importance }
function yval(d) { return d.Immediacy }
function rad(d) { return 0.04 * scaleFactor * (d.Cost) + 3.0 }
function shapefn(d) {
    var x = xval(d);
    var y = yval(d);
    return 1-2*((x-0.5)*(x-0.5)+(y-0.5)*(y-0.5));
}

/*Simple, fast, non-secure hash*/
function hash(str) {
    var hash = 0;
    if (!str ||	 str.length == 0) return hash;
    for (var i = 0; i < str.length; i++) {
        var chr = str.charCodeAt(i);
        hash = ((hash<<5)-hash)+chr;
        hash = hash & hash; // Convert to 32bit integer
    }
    return hash;
}
