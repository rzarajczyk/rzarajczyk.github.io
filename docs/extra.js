addEventListener('DOMContentLoaded', () => {
    let table = document.querySelector('#multiplication-table')
    if (table) {
        let html = ''

        html += '<th class="multiplication-table-header"></th>'
        for (let x=0; x<=9; x++) {
            html += `<th class="multiplication-table-header">${x}</th>`
        }

        for (let x=0; x<=9; x++) {
            html += '<tr>'
            html += `<td class="multiplication-table-header">${x}</td>`
            for (let y=0; y<=9; y++) {
                let type = ''
                if ([0, 1].includes(x) || [0, 1].includes(y)) {
                    type = 'q-very-simple'
                } else if ([2, 5].includes(x) || [2, 5].includes(y)) {
                    type = 'q-simple'
                } else if ([7, 8, 9].includes(x) || [7,8, 9].includes(y)) {
                    type = 'q-difficult'
                }
                html += `<td class="${type}">${x * y}</td>`
            }
            html += '</tr>'
        }
        table.innerHTML = html
    }
})