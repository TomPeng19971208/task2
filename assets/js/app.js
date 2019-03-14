// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery;
import "bootstrap";
import _ from "lodash";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
$(function () {
  function update_timeblock(task_id) {
    $.ajax(`${timeblock_path}?task_id=${task_id}`, {
    method: "get",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: (resp) => {
      console.log(resp);
      //var table = $( "#timeblock-table" ).DataTable();
      //$( "#timeblock-table" ).load( `${task_path}?task_id=${task_id}` + ' #timeblock-table' );
      location.reload(true);
    },
  });
  }

  //edit button for timblocks on task show Page
  $('.edit-timeblock-button').click((ev) => {
    let timeblock_id = $(ev.target).data('timeblock-id');
    toggle_timeblock_form('edit-timeblock-form'+timeblock_id);
  });

  //add button for timblocks
  $('#add-time-block-button').click((ev) => {
    console.log("add");
    toggle_timeblock_form('add-timeblock-form');
  });

  $('.timeblock-add-submit-button').click((ev) => {
    let task_id = $(ev.target).data('task-id');
    let start_time = document.getElementById('startTime').value;
    let end_time = document.getElementById('endTime').value;
    let data = JSON.stringify({
      timeblock: {
        start: new Date(start_time),
        end: new Date(end_time),
        task_id: task_id,
      },
    });
    $.ajax(timeblock_path, {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: data,
      success: (resp) => {
        toggle_timeblock_form('edit-timeblock-form'+timeblock_id);
        update_timeblock(task_id);
      },
    });
  });

  $('.timeblock-edit-submit-button').click((ev) => {
    console.log("submit");
    let task_id = $(ev.target).data('task-id');
    let timeblock_id = $(ev.target).data('timeblock-id');
    let start_time = document.getElementById('start').value;
    let end_time = document.getElementById('end').value;
    let data = JSON.stringify({
      timeblock: {
        start: new Date(start_time),
        end: new Date(end_time),
      },
    });
    $.ajax(`${timeblock_path}/${timeblock_id}`, {
      method: "patch",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: data,
      success: (resp) => {
        toggle_timeblock_form('edit-timeblock-form'+timeblock_id);
        update_timeblock(task_id);
      },
    });
  });


//delete button for timeblocks on task show page
  $('.timeblock-delete-button').click((ev) => {
    let task_id = $(ev.target).data('task-id');
    let timeblock_id = $(ev.target).data('timeblock-id');
    $.ajax(`${timeblock_path}/${timeblock_id}`, {
      method: "delete",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {
        update_timeblock(task_id);
      },
    });
  });


  $('#start-working-button').click((ev) => {
    console.log("start");
    let task_id = $(ev.target).data('task-id');
    let start_time = new Date();
    $('#stop-working-button').click((ev) => {
      console.log("stop")
      let data = JSON.stringify({
        timeblock: {
          task_id: task_id,
          start: start_time,
          end: new Date()
        },
      });
      $.ajax(window.timeblock_path, {
          method: "post",
          dataType: "json",
          contentType: "application/json; charset=UTF-8",
          data: data,
          success: (resp) => {
            update_timeblock(task_id);
            //console.log(resp.data.id);
        },
      });
  });
});
});

//show or hide a form
function toggle_timeblock_form(form_id) {
  let form = document.getElementById(form_id);
  if (form.style.display === 'none' || !form.style.display) {
   form.style.display = 'block';
  }
  else {
   form.style.display = 'none';
 }
}
