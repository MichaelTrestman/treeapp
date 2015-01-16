

// var AnimalTree = require('./treeData').AnimalTree

var DiscreteTraitDistribution = (function  (){

  var _tree = null;

  var recursivelyMapTraitsToClade = function(traits, node){
    Object.keys(traits).forEach(function(trait){
      node[trait] = traits[trait]
    });
    if(node.children) {
      node.children.forEach(function(child){
        recursivelyMapTraitsToClade(traits, child)
      })
    }
  }
  var recursivelySearchForOriginTaxaToMapFrom = function(node, originTaxa, traits){
    if (originTaxa.some(function(taxon){ return taxon === node.name }) ){
      recursivelyMapTraitsToClade(traits, node)
    } else if (node.children){
      if(node.children) {
        node.children.forEach(function(child){recursivelySearchForOriginTaxaToMapFrom(child, originTaxa, traits)
        })
      }
    }
  }

  return {

    setTree:function (tree) {
      _tree = tree;
    },
    outputTree: function(){
      return _tree;
    },
    treeName: function(){
      return _tree.name;
    },
    mapTraits: function(traits, originTaxa){
      recursivelySearchForOriginTaxaToMapFrom(_tree, originTaxa, traits)
    }
  }

}());

DiscreteTraitDistribution.setTree(AnimalTree)


OriginHypotheses = {
  humans: ['Humans'],
  greatApes: ['Hominidae'],
  mammals: ['Mammals'],
  amniotes: ['Amniotes'],
  bigThree: ['Vertebrates', 'Arthropods', 'Molluscs'],
  animals: ['Animals']

}



var recursivelySeekAndDestroyNode = function(startingNode, targetNodeName){
  if (startingNode.children) {
    startingNode.children.forEach(function(child, index){
      child.name == targetNodeName ? startingNode.children.splice(index, 1) : recursivelySeekAndDestroyNode(child, targetNodeName);
    })
  };
}



