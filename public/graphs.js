var margin = {top: 15, right: 1, bottom: 1, left: 1};
var width = 580;
var height = 320;
var scaleFactor = Math.sqrt(width*width + height*height);
var canvas = d3.select("#results_placeholder").append("svg")
    .attr("width", width)
    .attr("height", height)
    .attr("class", "dot chart")
    .append("g");
var svg = canvas.append("g")
    .attr('class', 'bckg')
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
var theDomIsStupid = 'o'; // Prefix for DOM entities

var allUsers = false;
d3.csv("/graphs.csv", createSvgElements);

function toggleGraph() {
    $("#all_data").toggleClass("graph_toggle_highlighted");
    $("#my_data").toggleClass("graph_toggle_highlighted");
    if (allUsers) {
        graphDraw("/graphs.csv");
        allUsers = false;
    } else {
        graphDraw("/graphs.csv?allUserFlag=true");
        allUsers = true;
    }
}
// graphDraw("/graphs.csv") for single user
// graphDraw("/graphs.csv?allUserFlag=true") for all users
function graphDraw(url) {
    d3.csv(url, function(d) {this.update(svg, d);});
}

function createSvgElements(data) {
    data.sort(function(a,b) {return b.Cost - a.Cost;});

    // Scale data to our viewport.
    var x = pad(d3.scale.linear()
        .domain(d3.extent(data, function(d) { return xval(d); }))
        .range([0, width - margin.left - margin.right]), 1);

    var y = pad(d3.scale.linear()
        .domain(d3.extent(data, function(d) { return yval(d); }))
        .range([height - margin.top - margin.bottom, 0]), 1);

    this.update = function(svg, data) {
        var x = pad(d3.scale.linear()
            .domain(d3.extent(data, function(d) { return xval(d); }))
            .range([0, width - margin.left - margin.right]), 1);

        var y = pad(d3.scale.linear()
            .domain(d3.extent(data, function(d) { return yval(d); }))
            .range([height - margin.top - margin.bottom, 0]), 1);

        svg.append("g").attr("class", "circles");
        svg.append("g").attr("class", "text");
        // DATA JOIN
        var circles = svg.select('.circles').selectAll("circle")
            .data(data, function(d) {return idFunc(d)});

        var text = svg.select('.text').selectAll("text")
            .data(data, function(d) {return idFunc(d)+'t'});

        // UPDATE
        // Update old data
        text.attr("class", "nodeText")
            .attr("id", function(d){return idFunc(d)+'t';})
            .text(function(d) {
                var txt = d['Problem Name'];
                if (txt.length > 65) {
                    txt = txt.slice(0,65) + '...';
                }
                return txt;
            })
            .attr("x", function(d) {return x(xval(d));})
            .attr("y", function(d) {return y(yval(d));})
            .attr("dx", function(d) {return 0.75*rad(d);})
            .attr("dy", function(d) {return -0.75*rad(d);})
            .attr("visibility", "hidden")
            .attr('dy', fixDYValue)
            .attr('dy', fixYDYValue)
            .attr('x', fixXValue);

        circles.attr("class", "dot")
            .attr("id", idFunc)
            .transition().duration(750)
            .attr("cx", function(d) { return x(xval(d)); })
            .attr("cy", function(d) { return y(yval(d)); })
            .attr("r", function(d) { return rad(d); })
            .attr("fill", function(d) { return cinterp(d.Complexity);});

        // ENTER: Create new elements as needed.
        circles.enter().insert("svg:circle")
            .on("mouseover", function(){
                d3.selectAll(".bckg").select('#'+this.id+'t')
                    .attr("visibility","visible");})
            .on("mouseout", function(){
                d3.selectAll(".bckg").select('#'+this.id+'t')
                    .attr("visibility","hidden");})
            .transition().duration(750)
            .attr("class", "dot")
            .attr("id", idFunc)
            .attr("cx", function(d) { return x(xval(d)); })
            .attr("cy", function(d) { return y(yval(d)); })
            .attr("r", function(d) { return rad(d); })
            .attr("fill", function(d) { return cinterp(d.Complexity);});
        text.enter().append("svg:text")
            .attr("class", "nodeText")
            .attr("id", function(d){return idFunc(d)+'t';})
            .attr("x", function(d) {return x(xval(d));})
            .attr("y", function(d) {return y(yval(d));})
            .attr("dx", function(d) {return 0.75*rad(d);})
            .attr("dy", function(d) {return -0.75*rad(d);})
            .text(function(d) {
                var txt = d['Problem Name'];
                if (txt.length > 65) {
                    txt = txt.slice(0,65) + '...';
                }
                return txt;
            })
            .attr("visibility", "hidden")
            .attr('dy', fixDYValue)
            .attr('dy', fixYDYValue)
            .attr('x', fixXValue);

// Problem data points represented as circles


        // EXIT
        // Remove old elements as needed.
        circles.exit().remove();
        text.exit().remove();
    };

    createLegend(canvas);
    this.update(svg, data);
    //allUsers();

    function individualUser() {
        d3.csv('/mock_graphs.csv', function(d) {update(svg, d);});
        setTimeout(allUsers, 3000);
    }

    function allUsers() {
        d3.csv('/mock_graphs2.csv', function(d) {update(svg, d);});
        setTimeout(individualUser, 3000);
    }

    function idFunc(d) {
        return theDomIsStupid+hash(d['Problem Name']);
    }

    function textLength(obj) {
        return parseInt(d3.select('#' + obj.id)[0][0].getComputedTextLength());
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

        var yArrow = legend.append("svg:polygon")
            .attr('points', '100,600 100,-200  500,200 500,-100  0,-600  -500,-100 -500,200 -100,-200 -100,600')
            .attr('transform', 'matrix(0.015, 0, 0, 0.015, 13, '+ ((height/2)-65) +')');

        var xArrow = legend.append("svg:polygon")
            .attr('points', '-600,100 200,100  -200,500 100,500 600,0 100,-500 -200,-500 200,-100 -600,-100')
            .attr('transform', 'matrix(0.015, 0, 0, 0.015,'+ ((width/2)+75) +', '+(height - 12)+')');
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

function key(d) { return d['Problem Name'] }
function xval(d) { return d.Importance }
function yval(d) { return d.Immediacy }
function rad(d) { return 0.04 * scaleFactor * (d.Cost) + 3.0 }

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
