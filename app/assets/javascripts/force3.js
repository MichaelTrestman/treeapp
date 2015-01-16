var WorkingTree = AnimalTree

var colors = {
  baseline: "rgba(10, 100, 10, 0.4)",
  conscious: "rgba(201, 181, 59, 0.4)",
  active: "rgba(200, 10, 40, 0.4)",
  flying: "rgba(22, 50, 200, 0.4)"
}

canvas = d3.select('#svg-panel').append('svg')
      .attr('class', 'svg-canvas');


width =  $('svg').width()
height = $('svg').height()
// width = parseInt( ($('body').attr('width') ) * 0.9)

var tree = d3.layout.tree();

var force = d3.layout.force()
  .charge(function(d){ return -d.charge})
  .gravity(0.5)
  .linkDistance(20)
  .size([width/2, height/2 + 50]);
var nodes, links, link, node, textitos, circulos;

nodes = tree(WorkingTree);
links = tree.links(nodes);

var positionNodes = function(){
  // circulos.attr("cx", function(d) { return d.x })
  //   .attr("cy", function(d) { return d.y; });
  // textitos.attr("x", function(d) { return d.x })
  //   .attr("y", function(d) { return d.y; });
  node.attr("transform", function (d) {
      return "translate(" + d.x.toString() + "," + d.y.toString() + ")";
    })
}
var positionLinks = function(){
  link.attr('d', function(d){
    pathstring = "" +
    "M " + parseInt(d.source.x).toString() + " " + parseInt(d.source.y).toString() +
    " T " + parseInt((d.target.x + d.source.x)/2  ).toString() + " " + parseInt((3 + d.target.y + d.source.y)/2).toString() +
    " T " + parseInt(d.target.x).toString() + " " + parseInt(d.target.y).toString() +
    " Z";
    return pathstring;
  }).style('fill', 'black');
}


// node = canvas.selectAll(".node")
//   .data(nodes);

// link = canvas.selectAll(".link")
//   .data(links);

  nodes = tree(WorkingTree);
  links = tree.links(nodes);

var setNodesAndLinks = function(){

  node = canvas.selectAll(".nodesicle")
    .data(nodes);

  link = canvas.selectAll(".link")
    .data(links);
}


var renderTree = function(){
  setNodesAndLinks();

  // canvas.selectAll(".nodesicle")
    // .data(nodes).exit().remove();
  node.exit().remove();
  link.exit().remove();

  // d3.selectAll('g').remove();
  // d3.selectAll('.node').remove();
  // d3.selectAll('path').remove();
  // d3.selectAll('.textito').remove();
  // d3.selectAll('.nodesicle').remove();


  link
    .enter()
    .append('path');
    // .attr('class', '.link');

  node
    .enter()
    .append("g").attr('class', 'nodesicle');
    // .attr("transform", function (d) {
    //     return "translate(" + d.x.toString() + "," + d.y.toString() + ")";
    //   })


  textitos = d3.selectAll('.nodesicle')
    .append('text')
    .text(function(d){return d.name})
    .attr("font-family", "sans-serif")
    .attr("font-size", "11px")
    .attr('class', 'textito')
    .style("fill", "black");
    // .attr('x', function(d){ return d.x }).attr('y', function(d){ return d.y });

  circulos = d3.selectAll('.nodesicle')
    .append('circle')
    .attr("class", "node")
    .attr('r', function(d){ return d.size*0.5});
    // .attr('cx', function(d){ return d.x }).attr('cy', function(d){return d.y });

  positionLinks();
  positionNodes();
  styleDat();
  node.call(force.drag);

}

force.on("tick", function() {
  positionLinks();
  positionNodes();
});

force
  .nodes(nodes)
  .links(links)
  .start();

renderTree();

var mdk = function(){
  recursivelySeekAndDestroyNode(WorkingTree, 'Bilateria');
}

$('.header').click(function(){

  // force
  //   .nodes(nodes)
  //   .links(links)
  //   .start();
  renderTree();


})


    // var scaleColor = d3.scale.linear()
    //                  .domain( [d3.min( nodes, function(d){ return d.name.length}), d3.max( nodes, function(d){ return d.name.length}) ])
    //                  .range( ["white", "black"]);
















    // var tooltip = d3.select("body")
    // .append("div")
    // .style("position", "absolute")
    // .style("z-index", "10")
    // .style("visibility", "hidden")
    // .style("color", "red")
    // .style("font-size", "2em")
    // .text("a simple tooltip");










//COLOR STUFF; refactor into module






function styleDat(){
  link.style('stroke', 'black')

  circulos.style('fill', function(d){
    var thisColor = colors.baseline

    Object.keys(colors).forEach(function(category){
      if (!!d[category]){
        thisColor = colors[category]
      }
    })

    return thisColor

  });

  // node.style('stroke', 'white')

  $('circle').off('mouseover').off('mouseout');

  circulos
    .on("mouseover", function(d){

        d3.select(this).style('fill', colors.active)

      // tooltip.text(d.name);
      // tooltip.style("visibility", "visible");
    })
    // .on("mousemove", function(){
    //   tooltip.style("top",
    //   (d3.event.pageY-10)+"px").style("left",(d3.event.pageX+10)+"px");
    // })
    // .off('mouseout')
    .on("mouseout", function(){
      d3.select(this).style('fill', function(d){
        var thisColor = colors.baseline

        Object.keys(colors).forEach(function(category){

          if (!!d[category]){

            thisColor = colors[category]
          }
        })

        return thisColor
      });
      // tooltip.style("visibility", "hidden");
    });

};

styleDat();

//timed alternation of displays


// setInterval(function(){

//   setTimeout(function(){
//     DiscreteTraitDistribution.mapTraits({"conscious": 'dolphinately'}, OriginHypotheses.humans)
//     styleDat();

//   }, 1000)

//   setTimeout(function(){
//     DiscreteTraitDistribution.mapTraits({"conscious": 'dolphinately'}, OriginHypotheses.mammals)
//     styleDat();

//   }, 2000)
//   setTimeout(function(){
//     DiscreteTraitDistribution.mapTraits({"conscious": 'dolphinately'}, OriginHypotheses.bigThree)
//     styleDat();

//   }, 3000)
//   setTimeout(function(){
//     DiscreteTraitDistribution.mapTraits({"conscious": 'dolphinately'}, OriginHypotheses.bilateria)
//     styleDat();

//   }, 4000)
//   setTimeout(function(){
//     DiscreteTraitDistribution.mapTraits({"conscious": null}, ['Animals'])
//     styleDat();

//   }, 5000)

// }, 5000)
