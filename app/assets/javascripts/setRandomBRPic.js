
    var setRandomBRPic = function(){
      var randomPic = function(){
        var picsCount = 1
        return (Math.floor(Math.random()*picsCount)+1).toString()
      }
      $('body').removeClass('black-br')
      $('body').removeClass('rad-br1')
      $('body').removeClass('rad-br2')
      var thisPicClass = randomPic();
      $('body').addClass('rad-br' + thisPicClass)
      console.log('rad-br' + thisPicClass)
      $('body').addClass('fixed-br')
      $('body').css('background-size', '100%')

    }