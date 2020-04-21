const run = () => {
    if (document.addEventListener) { // 兼容主流浏览器
        document.addEventListener('DOMContentLoaded',
            function a() {
                document.removeEventListener('DOMContentLoaded', a, false);
                // eslint-disable-next-line no-use-before-define
                Fn();
                // console.log('DOMContentLoaded')
            }
            // main
            , false);
    } else if (document.attachEvent) { // 兼容IE8+
        document.attachEvent('onreadystatechange', function a() {
            if (document.readyState === 'complete') {
                document.detachEvent('onreadystatechange', a);
                // eslint-disable-next-line no-use-before-define
                Fn();
                // console.log('onreadystatechange')
            }
        });

        if (document.documentElement.doScroll && typeof window.frameElement === 'undefined') { // 兼容低版本IE
            try {
                document.documentElement.doScroll('left');
            } catch (e) {
                // eslint-disable-next-line no-undef
                return setTimeout(run, 50);
            }
            // eslint-disable-next-line no-use-before-define
            Fn();
            // console.log('doScroll')
        }
    }
};
