/**
 * Copyright (C) 2017 Wasabeef
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

var RE = {};

// The current editing link
RE.currentEditingLink;

RE.currentSelection = {
    "startContainer": 0,
    "startOffset": 0,
    "endContainer": 0,
    "endOffset": 0};

// 标题部分
RE.article_title = document.getElementById('article_title');

// 内容部分
RE.editor = document.getElementById('article_content');

document.addEventListener("selectionchange", function() { RE.backuprange(); });

// Initializations
RE.callback = function() {
    //    window.location.href = "re-callback://" + encodeURI(RE.getHtml());
    RE.enabledEditingItems();
    
}
RE.touchCallback = function() {
    
    RE.enabledEditingItems();
    RE.enabledEditingItems();
    
}
RE.removeAllP = function(){
    // 获取所有的P元素
    var element,
    pElements = document.getElementsByTagName('p');
    // 删除所有P元素
    while (pElements.length>0) {
        element = pElements[0];
        element.parentElement.removeChild(element);
    }
}

RE.titleCallback = function() {
    window.location.href = "re-title-callback://" + encodeURI(RE.getTitle());
}

RE.setTitle = function(title) {
    RE.article_title.value = decodeURIComponent(title.replace(/\+/g, '%20'));
}

RE.setHtml = function(contents) {
    RE.editor.innerHTML = decodeURIComponent(contents.replace(/\+/g, '%20'));
}
RE.showBackTxt = function(){
    var target=document.getElementById("back-text");
    target.style.display="block";
    
}
//文章
window.onload = function(){
    RE.addP();
}
RE.addP = function(){
    var p=document.createElement("p");
    p.appendChild(document.createElement("br")); document.getElementById("article_content").appendChild(p);
}
RE.clearBackTxt = function(){
    var target=document.getElementById("back-text");
    target.style.display="none";
    
    //    RE.removeAllP();
}
// 点击了标题

// 点击了内容体
//document.getElementById("article_content").focus();

RE.getHtml = function() {
    return RE.editor.innerHTML;
}

RE.getTitle = function() {
    return RE.article_title.value;
}

RE.getText = function() {
    return RE.editor.innerText;
}

RE.setBaseTextColor = function(color) {
    RE.editor.style.color  = color;
}

RE.setBaseFontSize = function(size) {
    RE.editor.style.fontSize = size;
}

RE.setPadding = function(left, top, right, bottom) {
    RE.editor.style.paddingLeft = left;
    RE.editor.style.paddingTop = top;
    RE.editor.style.paddingRight = right;
    RE.editor.style.paddingBottom = bottom;
}

RE.setBackgroundColor = function(color) {
    document.body.style.backgroundColor = color;
}

RE.setBackgroundImage = function(image) {
    RE.editor.style.backgroundImage = image;
}

RE.setWidth = function(size) {
    RE.editor.style.minWidth = size;
}

RE.setHeight = function(size) {
    RE.editor.style.height = size;
}

RE.setTextAlign = function(align) {
    RE.editor.style.textAlign = align;
}

RE.setVerticalAlign = function(align) {
    RE.editor.style.verticalAlign = align;
}

RE.setPlaceholder = function(placeholder) {
    RE.editor.setAttribute("placeholder", placeholder);
    
}

RE.setInputEnabled = function(inputEnabled) {
    RE.editor.contentEditable = String(inputEnabled);
}

RE.undo = function() {
    document.execCommand('undo', false, null);
}

RE.redo = function() {
    document.execCommand('redo', false, null);
}

RE.setBold = function() {
    document.execCommand('bold', false, null);
    RE.enabledEditingItems();
}

RE.setItalic = function() {
    document.execCommand('italic', false, null);
    RE.enabledEditingItems();
}

RE.setSubscript = function() {
    document.execCommand('subscript', false, null);
    RE.enabledEditingItems();
}

RE.setSuperscript = function() {
    document.execCommand('superscript', false, null);
    RE.enabledEditingItems();
}

RE.setStrikeThrough = function() {
    document.execCommand('strikeThrough', false, null);
    RE.enabledEditingItems();
}

RE.setUnderline = function() {
    document.execCommand('underline', false, null);
    RE.enabledEditingItems();
}

RE.setBullets = function() {
    document.execCommand('insertUnorderedList', false, null);
    RE.enabledEditingItems();
}

RE.setNumbers = function() {
    document.execCommand('insertOrderedList', false, null);
    RE.enabledEditingItems();
}

RE.setTextColor = function(color) {
    RE.restorerange();
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('foreColor', false, color);
    document.execCommand("styleWithCSS", null, false);
}

RE.setTextBackgroundColor = function(color) {
    RE.restorerange();
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('hiliteColor', false, color);
    document.execCommand("styleWithCSS", null, false);
}

RE.setFontSize = function(fontSize){
    document.execCommand("fontSize", false, fontSize);
    RE.enabledEditingItems();
}

RE.setHeading = function(heading) {
    document.execCommand('formatBlock', false, '<h'+heading+'>');
    RE.enabledEditingItems();
}

RE.setIndent = function() {
    document.execCommand('indent', false, null);
    RE.enabledEditingItems();
}

RE.setOutdent = function() {
    document.execCommand('outdent', false, null);
    RE.enabledEditingItems();
}

RE.setJustifyLeft = function() {
    document.execCommand('justifyLeft', false, null);
    RE.enabledEditingItems();
}

RE.setJustifyCenter = function() {
    document.execCommand('justifyCenter', false, null);
    RE.enabledEditingItems();
}

RE.setJustifyRight = function() {
    document.execCommand('justifyRight', false, null);
    RE.enabledEditingItems();
}

RE.setBlockquote = function() {
    document.execCommand('formatBlock', false, '<blockquote>');
    RE.enabledEditingItems();
}

RE.insertImage = function(url, alt) {
    var html ="<br />" + '<img src="' + url + '" alt="' + alt + '" style="width:100%;"/>';
    RE.insertHTML(html);
}

RE.insertHTML = function(html) {
    //    RE.restorerange();
    document.execCommand('insertHTML', false, html);
}

RE.insertLink = function(url, title,content) {
    RE.restorerange();
    var sel = document.getSelection();
    console.log(sel);
    if (sel.toString().length != 0) {
        if (sel.rangeCount) {
            var el = document.createElement("a");
            el.setAttribute("href", url);
            el.setAttribute("title", title);
            el.setAttribute("content", content);
            var range = sel.getRangeAt(0).cloneRange();
            range.surroundContents(el);
            sel.removeAllRanges();
            sel.addRange(range);
        }
    }
    else
    {
        //        document.execCommand("insertHTML",false,"<a href='"+url+"'>"+title+"</a>");
        document.execCommand("insertHTML",false,"<a href='"+url+"' title = '"+content+"'>"+title+"</a>");
    }
    
    RE.enabledEditingItems();
}
RE.updateLink = function(url, title,content) {
    RE.restorerange();
    if (RE.currentEditingLink) {
        var c = RE.currentEditingLink;
        c.attr('href', url);
        c.attr('title', title);
        c.attr('content', content);
    }
    RE.enabledEditingItems();
    
}

//清除所有选中内容
RE.removeAllRanges = function(){
    　　　　window.getSelection().removeAllRanges();
};

//清除链接
RE.clearLink = function(){
    var node=window.getSelection().anchorNode;
    var span=document.createElement("span");
    span.innerText=node.parentNode.innerText;
    node.parentNode.parentNode.replaceChild(span,node.parentNode);
    
    var selection = window.getSelection();
    var range = document.createRange();
    range.selectNodeContents(span);
    selection.removeAllRanges();
    selection.addRange(range);
}

RE.insertLinkTitle = function(url, title) {
    RE.restorerange();
    var sel = document.getSelection();
    if (sel.toString().length == 0) {
        document.execCommand("insertHTML",false,"<a href='"+url+"'>"+title+"</a>");
    } else if (sel.rangeCount) {
        var el = document.createElement("a");
        el.setAttribute("href", url);
        el.setAttribute("title", title);
        var range = sel.getRangeAt(0).cloneRange();
        range.surroundContents(el);
        sel.removeAllRanges();
        sel.addRange(range);
    }
    RE.callback();
}

RE.setTodo = function(text) {
    var html = '<input type="checkbox" name="'+ text +'" value="'+ text +'"/> &nbsp;';
    document.execCommand('insertHTML', false, html);
}

RE.removeAllHtml = function (html) {
    return html.replace(/<[^>]+>/g, '');
};
RE.prepareInsert = function() {
    RE.backuprange();
}

RE.backuprange = function(){
    var selection = window.getSelection();
    if (selection.rangeCount > 0) {
        var range = selection.getRangeAt(0);
        RE.currentSelection = {
            "startContainer": range.startContainer,
            "startOffset": range.startOffset,
            "endContainer": range.endContainer,
            "endOffset": range.endOffset};
    }
}

RE.restorerange = function(){
    var selection = window.getSelection();
    selection.removeAllRanges();
    var range = document.createRange();
    range.setStart(RE.currentSelection.startContainer, RE.currentSelection.startOffset);
    range.setEnd(RE.currentSelection.endContainer, RE.currentSelection.endOffset);
    selection.addRange(range);
}

RE.enabledEditingItems = function() {
    var items = [];
    
    //    window.location.href = "re-state-content-change://";
    
    
    var fontSizeblock = document.queryCommandValue('fontSize');
    if (fontSizeblock.length > 0) {
        items.push(fontSizeblock);
    }
    
    if (document.queryCommandState('bold')) {
        items.push('bold');
    }
    
    if (document.queryCommandState('italic')) {
        items.push('italic');
    }
    if (document.queryCommandState('subscript')) {
        items.push('subscript');
    }
    if (document.queryCommandState('superscript')) {
        items.push('superscript');
    }
    if (document.queryCommandState('strikeThrough')) {
        items.push('strikeThrough');
    }
    if (document.queryCommandState('underline')) {
        items.push('underline');
    }
    if (document.queryCommandState('insertOrderedList')) {
        items.push('orderedList');
    }
    if (document.queryCommandState('insertUnorderedList')) {
        items.push('unorderedList');
    }
    if (document.queryCommandState('justifyCenter')) {
        items.push('justifyCenter');
    }
    if (document.queryCommandState('justifyFull')) {
        items.push('justifyFull');
    }
    if (document.queryCommandState('justifyLeft')) {
        items.push('justifyLeft');
    }
    if (document.queryCommandState('justifyRight')) {
        items.push('justifyRight');
    }
    if (document.queryCommandState('insertHorizontalRule')) {
        items.push('horizontalRule');
    }
    //    if (document.queryCommandState('indent')) {
    //        items.push('indent');
    //    }
    //    if (document.queryCommandState('outdent')) {
    //        items.push('outdent');
    //    }
    var formatBlock = document.queryCommandValue('formatBlock');
    if (formatBlock.length > 0) {
        items.push(formatBlock);
    }
    
    
    if (items.length > 0) {
        window.location.href = "re-state-content://" + encodeURI(items.join(','));
        window.location.href = "re-state-content://" + encodeURI(items.join(','));
    } else {
        window.location.href = "re-state-content://";
    }
}

RE.article_title.onfocus = function(){
    window.location.href = "re-state-title://";
};

RE.focus = function() {
    var range = document.createRange();
    range.selectNodeContents(RE.editor);
    range.collapse(false);
    var selection = window.getSelection();
    selection.removeAllRanges();
    selection.addRange(range);
    RE.editor.focus();
}

RE.blurFocus = function() {
    RE.editor.blur();
}

RE.removeFormat = function() {
    document.execCommand('removeFormat', false, null);
}

// Event Listeners
RE.editor.addEventListener("input", RE.callback);
RE.article_title.addEventListener("input",RE.titleCallback);
RE.editor.addEventListener("keyup", function(e) {
                           var KEY_LEFT = 37, KEY_RIGHT = 39;
                           if (e.which == KEY_LEFT || e.which == KEY_RIGHT||e.which == 8 ||e.which == 13) {
                           RE.enabledEditingItems(e);
                           
                           }
                           });

RE.editor.addEventListener("touchend", RE.touchCallback);

function htmlEscape(html) {
    var temp = document.createElement("div");
    (temp.textContent != null) ? (temp.textContent = html) : (temp.innerText = html);
    var output = temp.innerHTML;
    temp = null;
    return output;
}
// 转码
function htmlUnEscape(text) {
    var temp = document.createElement("div");
    temp.innerHTML = text;
    var output = temp.innerText || temp.textContent;
    temp = null;
    return output;
}
function keyAction(obj) {
    var textbox = document.getElementById(obj);
    var sel = window.getSelection();
    var range = document.createRange();
    range.selectNodeContents(textbox);
    range.collapse(false);
    sel.removeAllRanges();
    sel.addRange(range);
}


//自动滚动处理
RE.getCaretYPosition = function() {
    var sel = window.getSelection();
    // Next line is comented to prevent deselecting selection. It looks like work but if there are any issues will appear then uconmment it as well as code above.
    //sel.collapseToStart();
    var range = sel.getRangeAt(0);
    var span = document.createElement('span');// something happening here preventing selection of elements
    range.collapse(false);
    range.insertNode(span);
    var topPosition = span.offsetTop;
    span.parentNode.removeChild(span);
    return topPosition;
}

RE.autoScroll = function(topY){
    window.scrollTo(0,topY);
    
}

//开始上传-文章
RE.insertImageBase64String = function(imageData,imgId) {
    
    RE.restorerange();
    //        var html = '<div id="'+imgId+'" class="main-img-case loading"><div><img src="data:image/jpeg;base64,'+imageData+'" alt="'+imgId+'" /></div></div>';
    var html='<br />'  + '<div  contenteditable="false" id="'+imgId+'" class="main-img-case loading" tabindex="0">'+
    '</div>'+ '<br />';
    
    RE.insertHTML(html);
    insertHtml(imageData,imgId);
    function insertHtml(imageData, imgId){
        var imgStr='<div class="loading-case">'+
        '<div class="loading-bar-case">'+
        '<div class="loading-bar"></div>'+
        '</div>'+
        '<div class="reload-btn btn">'+
        '<div class="reload-btn-ico"><img src="icon_refresh.png" alt=""></div>'+
        '<div class="reload-btn-txt">重新上传</div>'+
        '</div>'+
        '<img class="real-img" src="data:image/png;base64,'+ imageData +'">'+
        '</div>';
        
        $("#"+imgId).html(imgStr);
        $("#"+imgId+" .reload-btn").hide();
    }
    RE.enabledEditingItems();
    
    
    var flag = false;
    window.addEventListener("touchmove",function(event){
                            setTimeout(function(){
                                       }, 50);
                            });
    $("#"+imgId).on("touchend",function(event){
                    RE.uploadOver(imgId);
                    event.stopPropagation();
                    });
}

//图片上传进度
RE.uploadImg = function(imgId,progress){
    var loadingBarWidth=(progress*100)+"%";
    $("#"+imgId+" .loading-bar").width(loadingBarWidth);
}

//图片上传成功
RE.insertSuccessReplaceImg =function(imgId,imgUrl){
    var imgStr='<img id="'+imgId+'-img" class="real-img" src="'+ imgUrl +'">'+'<br />';
    $("#"+imgId).after(imgStr);
    $("#"+imgId).remove();
    
    var flag = false;
    window.addEventListener("touchmove",function(event){
                            flag = true;
                            setTimeout(function(){
                                       flag = false;
                                       }, 50);
                            });
    $("#"+imgId+"-img").on("touchend",function(event){
                           if(flag==true){
                           return;
                           }
                           RE.canFocus(false);
                           RE.uploadOver(imgId);
                           event.stopPropagation();
                           });
}
//设置编辑器是否不可编辑
RE.canFocus = function(bool){
    $("#article_content").attr("contenteditable",bool);
}

//图片上传失败
RE.uploadError = function(imgId){
    $("#"+imgId+" .reload-btn").show();
    var flag = false;
    window.addEventListener("touchmove",function(event){
                            flag = true;
                            setTimeout(function(){
                                       flag = false;
                                       }, 50);
                            });
    $("#"+imgId).on("touchend",function(event){
                    if(flag==true){
                    return;
                    }
                    RE.canFocus(false);
                    RE.uploadOver(imgId);
                    event.stopPropagation();
                    });
}

//删除图片
RE.removeImg = function(imgId){
    $("#"+imgId).remove();
    $("#"+imgId+"-img").remove();
}

//图片上传中||结束||失败的监听
RE.uploadOver = function(imgId){
    var json = {"imgId": imgId};
    window.location.href= "protocol://" + encodeURI("iOS?code=uploadResult&data="+JSON.stringify(json));
}
RE.removeErrorBtn = function(imgId,isHide){
    var reBtn=$("#"+imgId+" .reload-btn");
    isHide?reBtn.hide():reBtn.show();
}
