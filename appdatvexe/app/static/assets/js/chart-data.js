const labels_month = ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6'
            , 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'];
const chartsByCanvasId = {};
let select_year = null
$(document).ready(() => {
    current_year = (new Date().getFullYear()).toString()

    stats_trips_by_line()

    select_year = $("div.legend input[name='checkbox_year']")
    
    stats_month(current_year)
    stats_quarter(current_year)

    select_year.change(async function (e) {
        let year = e.target.value
        stats_month(year)
        stats_quarter(year)
    })
})

const destroyChartIfNecessary = (canvasId) => {
    if (chartsByCanvasId[canvasId]) {
        chartsByCanvasId[canvasId].destroy();
    }
}

const registerNewChart = (canvasId, chart) => {
    chartsByCanvasId[canvasId] = chart;
}

const random_bg_color = () => {
    const x = Math.floor(Math.random() * 256);
    const y = Math.floor(Math.random() * 256);
    const z = Math.floor(Math.random() * 256);
    return "rgb(" + x + "," + y + "," + z + ")";
}

const stats_month = async (year) => { 
    let data = await fetch('http://127.0.0.1:8000/admin/stats/month?year=' + year).then(res => res.json())
    
    let data_month = []
    let label = Object.keys(data).map(k => {
        data_month.push(data[k])
        return labels_month[parseInt(k) - 1]
    })
    
    let backgroundColor = data_month.map(i => random_bg_color())
    
    let datasets = {
        data: data_month,
        backgroundColor: backgroundColor,
        borderColor: backgroundColor,
        borderWidth: 1,
        barPercentage: 0.3,
        minBarLength: 20,
    }

    let data_drawn = {
        labels: label,
        datasets: [datasets,]
    }
    
    let canvasid = "month-chart"
    destroyChartIfNecessary(canvasid)
    let chart = chart_bar(canvasid, "Thống kê doanh số tháng theo năm " + year, data_drawn)
    registerNewChart(canvasid, chart)    
}

const stats_quarter = async (year) => { 
    let data = await fetch('http://127.0.0.1:8000/admin/stats/quarter?year=' + year).then(res => res.json())
    
    let data_quarter = []
    let label = Object.keys(data).map(k => {
        data_quarter.push(data[k])
        return 'Quý ' + k
    })
    
    let backgroundColor = data_quarter.map(i => random_bg_color())
    
    let datasets = {
        data: data_quarter,
        backgroundColor: backgroundColor,
        borderColor: backgroundColor,
        borderWidth: 1,
        barPercentage: 0.3,
        minBarLength: 20,
    }

    let data_drawn = {
        labels: label,
        datasets: [datasets,]
    }
    
    let canvasid = "quarter-chart"
    destroyChartIfNecessary(canvasid)
    let chart = chart_bar(canvasid, "Thống kê doanh số quý theo năm " + year, data_drawn)
    registerNewChart(canvasid, chart)    
}

const stats_trips_by_line = async () => {

    let data = await fetch('http://127.0.0.1:8000/admin/stats/trips').then(res => res.json())
    
    let data_trip = []
    let label = Object.keys(data).map(k => {
        data_trip.push(data[k])
        return 'Tuyến ' + k
    })
    
    let backgroundColor = data_trip.map(i => random_bg_color())
    
    let datasets = {
        data: data_trip,
        backgroundColor: backgroundColor,
        borderColor: backgroundColor,
        borderWidth: 1,
        barPercentage: 0.3,
        minBarLength: 20,
    }

    let data_drawn = {
        labels: label,
        datasets: [datasets,]
    }
    
    let canvasid = "trips-chart"
    destroyChartIfNecessary(canvasid)
    let chart = chart_bar(canvasid, "Thống kê mật độ chuyến theo tuyến", data_drawn)
    registerNewChart(canvasid, chart)
}

const chart_bar = (canvans_id, str_title, data) => {
    let ctx = $("#" + canvans_id)

    return new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            color: 'red'
                        }
                    },
                    x: {

                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    title: {
                        display: true,
                        text: str_title
                    },
                    tooltip: {
                        callbacks: {
                            footer: (bar)=>  "Tổng doanh số: " + bar[0].raw
                            ,
                        }
                    }
                }
            }
        }
    )
}

