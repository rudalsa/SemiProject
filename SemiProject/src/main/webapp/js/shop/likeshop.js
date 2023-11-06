function golike(ctxPath) {
    
    // URL에서 g_code 매개변수 가져오기
    const urlParams = new URLSearchParams(window.location.search);
    const g_code = urlParams.get('g_code');

    if (g_code) {
        // g_code 값을 배열에 추가
        const g_code_arr = sessionStorage.getItem('g_code_arr') ? JSON.parse(sessionStorage.getItem('g_code_arr')) : [];
        
        g_code_arr.push(g_code);

        // 최대 3개 값만 유지
        if (g_code_arr.length > 3) {
            g_code_arr.shift();
        }

        // 배열을 세션 스토리지에 다시 저장
        sessionStorage.setItem('g_code_arr', JSON.stringify(g_code_arr));
        console.log('g_code_arr:', g_code_arr);

        // 팝업을 열기
        openPopup(ctxPath, g_code_arr);
        
    } else {
        // g_code가 없는 경우 처리
    }
}

function openPopup(ctxPath, g_code_arr) {
    const url = `${ctxPath}/shop/likecart.bz`;

    const width = 1200; // 가로 크기를 1200px로 설정
    const height = 600; // 세로 크기를 600px로 설정

    const left = Math.ceil((window.screen.width - width) / 2);
    const top = Math.ceil((window.screen.height - height) / 2);

    // 가로 1200px, 세로 600px 크기로 팝업 열기
    window.open(`${url}?g_code_arr=${g_code_arr.join(",")}`, "likecart", `left=${left}, top=${top}, width=${width}, height=${height}`);
}