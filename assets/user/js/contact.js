$(document).on("click", ".js-copy-contact", function () {
    const text = $(this).data("copy");
    const label = $(this).data("label") || "联系方式";

    if (navigator.clipboard && window.isSecureContext) {
        navigator.clipboard.writeText(text).then(function () {
            layer.msg(label + "已复制：" + text);
        }).catch(function () {
            window.prompt("请复制" + label, text);
        });
        return;
    }

    window.prompt("请复制" + label, text);
});
