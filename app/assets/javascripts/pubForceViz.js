PubForceViz = function(data){
var root = data;
var diameter = 1100;

var tree = d3.layout.tree()
    .size([300, diameter / 5 - 0])
    .separation(function(a, b) { return (a.parent == b.parent ? 1 : 2) / a.depth; });

var diagonal = d3.svg.diagonal.radial()
    .projection(function(d) { return [d.y, d.x / 180 * Math.PI]; });

var svg = d3.select("svg")
  // .attr('transform', 'translate(' + 400 + ',' + 400 +')');
  // .append("svg")
  //   .attr("width", diameter + 20)
  //   .attr("height", diameter - 40)
  // .append("g")
  //   .attr("transform", "translate(" + diameter / 2 + "," + diameter / 2 + ")");

  var nodes = tree.nodes(root),
      links = tree.links(nodes);

  var link = svg.selectAll(".link")
      .data(links)
    .enter().append("path")
      .attr("class", "link")
      .attr("d", diagonal);

  var node = svg.selectAll(".node")
      .data(nodes)
    .enter().append("g")
      .attr("class", "node")
      .attr("transform", function(d) { return "rotate(" + (d.x - 90) + ")translate(" + d.y + ")"; })
      // .attr('transform', function(d){ return 'translate(' + '0' +')'})

  node.append("circle")
      .attr("r", 5);

  node.append("text")
      .attr("dy", ".1em")
      .attr("text-anchor", function(d) { return d.x < 180 ? "start" : "end"; })
      .attr("transform", function(d) { return d.x < 180 ? "translate(8)" : "rotate(180)translate(-8)"; })
      .text(function(d) { return d.title ? d.title : d.author_name; });

d3.select(self.frameElement).style("height", diameter - 150 + "px");
}







// PubForceViz = {

//   render: function(data){
//       var node, link;

//       var setNodesAndLinks = function(){
//         node = canvas.selectAll('.node')
//           .data(nodes);
//         link = canvas.selectAll('.link')
//           .data(links);
//       }
//       // var positionNodes = function(){
//       //   node.attr("transform", function(d){
//       //     console.log(d.x)
//       //     return "translate(" + d.x + "," + d.y + ")";
//       //   })
//       // }
//       // var positionLinks = function(){
//       //   link.attr('d', function(d){
//       //     console.log(d.x)
//       //     pathstring = '' +
//       //     "M " + parseInt(d.source.x).toString() + " " + parseInt(d.source.y).toString() +
//       //   " T " + parseInt((d.target.x + d.source.x)/2  ).toString() + " " + parseInt((3 + d.target.y + d.source.y)/2).toString() +
//       //   " T " + parseInt(d.target.x).toString() + " " + parseInt(d.target.y).toString() +
//       //   " Z";
//       //   return pathstring;
//       //   })
//       // }

//     // console.log(data)

//     canvas = d3.select('svg');

//     tree = d3.layout.tree();
//     // force = d3.layout.force()
//     //   .charge(function(d){ return 100 })
//     //   .gravity(0.3)
//     //   .linkDistance(10)
//     //   .size(50, 50)
//     nodes = tree(data);
//     links = tree.links(nodes);

//     setNodesAndLinks();

//     canvas.selectAll("path")
//     .data(tree.links(nodes))
//   .enter().append("path")
//     .attr("d", d3.svg.diagonal());


//     // node
//     //   .enter()
//     //   .append('g')
//     //   .attr('class', 'node');

//     // circles = d3.selectAll('.node')
//     //   .append('circle')
//     //   .attr('class', 'circle')
//     //   .attr('r', function(d){ return d.size })
//     //   .style('fill', 'blue')
//     // link
//     //   .enter()
//     //   .append('path');



//     // positionNodes();
//     // positionLinks();

//     // force.on('tick', function(){
//     //   positionNodes();
//     //   positionLinks();
//     // });

//     // force
//     //   .nodes(nodes)
//     //   .links(links)
//     //   .start();

//   }


// }

