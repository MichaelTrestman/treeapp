  // $("#" + origHyp).click(function(){
  //   DiscreteTraitDistribution.mapTraits({"conscious": null}, ['Animals'])
  //   DiscreteTraitDistribution.mapTraits({"conscious": 'dolphinately'}, OriginHypotheses[origHyp])
  //   console.log('yo: ' + origHyp)
  //   styleDat();

// DiscreteTraitDistribution.mapTraits(
//   {
//     'flying': 'like a (flying) fox'
//   },
//   ['Birds', 'Insects', 'Bats', 'Pterosaurs']
// )
// styleDat();


Object.keys(OriginHypotheses).forEach(function(origHyp){

  $("#" + origHyp).on('mouseenter', function(){
    DiscreteTraitDistribution.mapTraits({"conscious": null}, ['Animals'])
    DiscreteTraitDistribution.mapTraits({"conscious": 'dolphinately'}, OriginHypotheses[origHyp])
    styleDat();
  })

})


//display shit on info panel

var infoPanelInitialize = (function(){
  $('.node').on('mouseenter', function(d){
    clade = d.target.__data__
    var panel = $('#info-panel')
    panel.css('min-height','300px')
    var url;

    if (clade['species-diversity-source'] === 'unknown') {
      url = "https://www.google.com/search?q=" + clade.name;
    } else if (clade['species-diversity-source']) {
      url = clade['species-diversity-source']
    };;

    panel.empty();

    panel.append("<p id=''>"+ clade.name +"</p>")
    panel.append("<p> species count:"+ clade['species-diversity'] +"</p>")
    panel.append("<p><a target='_blank' href='"+ url + " '>  website: "+ url +"</a></p>")
  })
}())