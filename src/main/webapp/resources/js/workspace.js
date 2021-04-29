function viewCardClick(clickedId)
{
    $('.modal-body').load("/App/viewCard.htm?cardId="+clickedId,function(){
        $('#myModal').modal({show:true});
    });
}
function editCardClick(clickedId)
{
    $('.modal-body').load("/App/updateCard.htm?cardId="+clickedId,function(){
        $('#myModal').modal({show:true});
        $('#cp-component').colorpicker();
    });
}
function handleSettingsClick()
{
    $('.modal-body').load("/App/settings.htm",function(){
        $('#myModal').modal({show:true});
    });
}