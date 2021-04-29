$.ajaxSetup ({
    // Disable caching of AJAX responses
    cache: false
});

function viewInvitesClick()
{
    $('.modal-body').load("/App/viewInvites.htm",function(){
        $('#myModal').modal({show:true});
    });
}
function addWorkspaceClick()
{
    $('.modal-body').load("/App/addWorkspace.htm",function(){
        $('#myModal').modal({show:true});
    });
}