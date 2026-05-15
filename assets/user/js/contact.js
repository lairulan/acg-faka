function showContactCopied(label, text) {
    if (window.layer && typeof layer.msg === "function") {
        layer.msg(label + "已复制：" + text);
        return;
    }

    alert(label + "已复制：" + text);
}

function showContactCopyFallback(label, text) {
    window.prompt("请复制" + label, text);
}

function copyContactWithSelection(text) {
    const textarea = document.createElement("textarea");

    textarea.value = text;
    textarea.setAttribute("readonly", "readonly");
    textarea.style.position = "fixed";
    textarea.style.top = "-1000px";
    textarea.style.left = "-1000px";
    textarea.style.opacity = "0";

    document.body.appendChild(textarea);
    textarea.focus();
    textarea.select();
    textarea.setSelectionRange(0, text.length);

    try {
        return document.execCommand("copy");
    } catch (e) {
        return false;
    } finally {
        document.body.removeChild(textarea);
    }
}

$(document).on("click", ".js-copy-contact", function () {
    const text = String($(this).data("copy") || "");
    const label = $(this).data("label") || "联系方式";

    if (!text) {
        return;
    }

    if (copyContactWithSelection(text)) {
        showContactCopied(label, text);
        return;
    }

    if (navigator.clipboard && window.isSecureContext) {
        navigator.clipboard.writeText(text).then(function () {
            showContactCopied(label, text);
        }).catch(function () {
            showContactCopyFallback(label, text);
        });
        return;
    }

    showContactCopyFallback(label, text);
});
