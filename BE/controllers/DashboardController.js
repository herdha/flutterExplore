const driver = require("../models/Driver")
const Vehicle = require("../models/Vehicle")
const Receive = require("../models/Receive")
const Unpacking = require("../models/Unpacking")
const Putaway = require("../models/Putaway")
const Picking = require("../models/Picking")
const Packing = require("../models/Packing")
const Delivery = require("../models/Delivery")

exports.dataDriver = async (req, res) => {
    await driver.find()
    .then((d)=>{
        // grouping data by status
        let group = d.reduce((acc, index) => {
            acc[index.status] = [...acc[index.status] || [], index];
            return acc;
        }, {});
        
        // data response
        const result = [
            {
                title: 'Available',
                total: group['AVAILABLE'].length
            },
            {
                title: 'Not Available',
                total: group['NOT AVAILABLE'].length
            }
        ]
        res.status(200).send(result)
    })
    .catch((e)=>{
        res.status(404).send({message: e.message})
    })

    // await driver.aggregate([
    //     {
    //         $group: {
    //             _id: '$status',
    //             total: {$sum: 1}
    //         }
    //     },
    //     {
    //         $project: {
    //             title: '$_id',
    //             total: '$total',
    //             _id: false
    //         }
    //     }
    // ])
    // .then((d)=>{
    //     res.status(200).send(d)
    // })
    // .catch((e)=>{
    //     res.status(404).send({message: e.message})
    // })
}

exports.dataVehicle = async (req, res) => {
    await Vehicle.find()
    .then((d)=>{
        // grouping data by status
        let group = d.reduce((acc, index) => {
            acc[index.status] = [...acc[index.status] || [], index];
            return acc;
        }, {});
        
        // data response
        const result = [
            {
                title: 'Available',
                total: group['AVAILABLE'].length
            },
            {
                title: 'Not Available',
                total: group['NOT AVAILABLE'].length
            }
        ]
        res.status(200).send(result)
    })
    .catch((e)=>{
        res.status(404).send({message: e.message})
    })
    
    // await Vehicle.aggregate([
    //     {
    //         $group: {
    //             _id: '$status',
    //             total: {$sum: 1}
    //         }
    //     },
    //     {
    //         $project: {
    //             title: '$_id',
    //             total: '$total',
    //             _id: false
    //         }
    //     }
    // ])
    // .then((d)=>{
    //     res.status(200).send(d)
    // })
    // .catch((e)=>{
    //     res.status(404).send({message: e.message})
    // })
}

exports.dataInvsOut = async (req, res) => {
    
    const totalReceive = await Receive.find()
        .then((d)=>{
            return d.length
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })
    
    const totalUnpacking = await Unpacking.find()
        .then((d)=>{
            return d.length
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })
    
    const totalPutaway = await Putaway.find()
        .then((d)=>{
            return d.length
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })
    // end inbound

    // start oubound
    const totalPicking = await Picking.find()
        .then((d)=>{
            return d.length
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })
    
    const totalPacking = await Packing.find()
        .then((d)=>{
            return d.length
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })
    
    const totalDelivery = await Delivery.find()
        .then((d)=>{
            return d.length
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })
    // end outbound
    
    const totalIn = totalReceive + totalUnpacking + totalPutaway
    const totalOut = totalPicking + totalPacking + totalDelivery

    const data = [
        { title: 'Inbound', total: totalIn },
        { title: 'Outbound', total: totalOut }
    ]

    res.status(200).send(data)
    
    // let totalReceive, totalUnpacking, totalPutaway, totalIn, totalPicking, totalPacking, totalDelivery, totalOut = null
    // let data = []
    // let dataIn, dataOut = null
    
    // // start inbound
    // await Receive.find()
    // .then((d)=>{
    //     totalReceive = d[0].data.length
    // })
    // .catch((e)=>{
    //     res.send(e)
    // })
    
    // await Unpacking.find()
    // .then((d)=>{
    //     totalUnpacking = d[0].data.length
    // })
    // .catch((e)=>{
    //     res.send(e)
    // })
    
    // await Putaway.find()
    // .then((d)=>{
    //     totalPutaway = d[0].data.length
    // })
    // .catch((e)=>{
    //     res.send(e)
    // })
    // // end inbound

    // // start oubound
    // await Picking.find()
    // .then((d)=>{
    //     totalPicking = d[0].data.length
    // })
    // .catch((e)=>{
    //     res.send(e)
    // })
    
    // await Packing.find()
    // .then((d)=>{
    //     totalPacking = d[0].data.length
    // })
    // .catch((e)=>{
    //     res.send(e)
    // })
    
    // await Delivery.find()
    // .then((d)=>{
    //     totalDelivery = d[0].data.length
    // })
    // .catch((e)=>{
    //     res.send(e)
    // })
    // // end outbound
    
    // totalIn = totalReceive + totalUnpacking + totalPutaway
    // totalOut = totalPicking + totalPacking + totalDelivery

    // dataIn = { title: 'Inbound', total: totalIn }
    // dataOut = { title: 'Outbound', total: totalOut }
    // data.push(dataIn)
    // data.push(dataOut)

    // console.log(data)
    
    // res.status(200).send(data)
}

exports.dataInboundMonth = async (req, res) => {
    const receive = await Receive.find({},{createdAt:1, _id:0})
        .then((d)=>{
            const groupedByMonth = {};

            d.forEach((item) => {
                const date = new Date(item.createdAt);
                const monthName = date.toLocaleString('default', { month: 'short' });
                if (!groupedByMonth[monthName]) {
                    groupedByMonth[monthName] = 0;
                }
                groupedByMonth[monthName]++;
            });

            return Object.keys(groupedByMonth).map((month) => {
                return {
                    "month": month,
                    "total": groupedByMonth[month]
                }
            });
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })
    
    const unpacking = await Unpacking.find({},{createdAt:1, _id:0})
        .then((d)=>{
            const groupedByMonth = {};

            d.forEach((item) => {
                const date = new Date(item.createdAt);
                const monthName = date.toLocaleString('default', { month: 'short' });
                if (!groupedByMonth[monthName]) {
                    groupedByMonth[monthName] = 0;
                }
                groupedByMonth[monthName]++;
            });

            return Object.keys(groupedByMonth).map((month) => {
                return {
                    "month": month,
                    "total": groupedByMonth[month]
                }
            });
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })
    
    const putaway = await Putaway.find({},{createdAt:1, _id:0})
        .then((d)=>{
            const groupedByMonth = {};

            d.forEach((item) => {
                const date = new Date(item.createdAt);
                const monthName = date.toLocaleString('default', { month: 'short' });
                if (!groupedByMonth[monthName]) {
                    groupedByMonth[monthName] = 0;
                }
                groupedByMonth[monthName]++;
            });

            return Object.keys(groupedByMonth).map((month) => {
                return {
                    "month": month,
                    "total": groupedByMonth[month]
                }
            });
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })

    res.status(200).send({receive, unpacking, putaway})
    // console.log({receive, unpacking, putaway})
    // let receiveData, unpackingData, putawayData, inboundData = null
    // // let today = new Date();
    // // let firstDay = new Date(today.getFullYear(), today.getMonth(), 2);
    // // let lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 1);
    // let confDate = [
    //     {
    //         $unwind: {
    //             path: '$data'
    //         }
    //     },
    //     {
    //         $group: {
    //             _id: {
    //                 $month: { $toDate: "$data.createdAt" }
    //             },
    //             total: {
    //                 $sum: 1,
    //             }
    //         }
    //     },
    //     {
    //         $project: {
    //             month: '$_id',
    //             total: '$total',
    //             _id: false
    //         }
    //     }
    // ]
    
    // // get data receive
    // await Receive.aggregate(confDate)
    // .then((d)=>{
    //     receiveData = d
    //     console.log(receiveData)
    // })
    // .catch((e)=>{
    //     res.status(404).send({message: e.message})
    // })
    
    // // get data unpacking
    // await Unpacking.aggregate(confDate)
    // .then((d)=>{
    //     unpackingData = d
    //     console.log(unpackingData)
    // })
    // .catch((e)=>{
    //     res.status(404).send({message: e.message})
    // })

    // // get data putaways
    // await Putaway.aggregate(confDate)
    // .then((d)=>{
    //     putawayData = d
    //     console.log(putawayData)
    // })
    // .catch((e)=>{
    //     res.status(404).send({message: e.message})
    // })

    // inboundData = {
    //     receive: receiveData,
    //     unpacking: unpackingData,
    //     putaway: putawayData
    // }

    // res.status(200).send(inboundData)
}

exports.dataOutboundMonth = async (req, res) => {
    
    const picking = await Picking.find({},{createdAt:1, _id:0})
        .then((d)=>{
            const groupedByMonth = {};

            d.forEach((item) => {
                const date = new Date(item.createdAt);
                const monthName = date.toLocaleString('default', { month: 'short' });
                if (!groupedByMonth[monthName]) {
                    groupedByMonth[monthName] = 0;
                }
                groupedByMonth[monthName]++;
            });

            return Object.keys(groupedByMonth).map((month) => {
                return {
                    "month": month,
                    "total": groupedByMonth[month]
                }
            });
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })
    
    const packing = await Packing.find({},{createdAt:1, _id:0})
        .then((d)=>{
            const groupedByMonth = {};

            d.forEach((item) => {
                const date = new Date(item.createdAt);
                const monthName = date.toLocaleString('default', { month: 'short' });
                if (!groupedByMonth[monthName]) {
                    groupedByMonth[monthName] = 0;
                }
                groupedByMonth[monthName]++;
            });

            return Object.keys(groupedByMonth).map((month) => {
                return {
                    "month": month,
                    "total": groupedByMonth[month]
                }
            });
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })
    
    const delivery = await Delivery.find({},{createdAt:1, _id:0})
        .then((d)=>{
            const groupedByMonth = {};

            d.forEach((item) => {
                const date = new Date(item.createdAt);
                const monthName = date.toLocaleString('default', { month: 'short' });
                if (!groupedByMonth[monthName]) {
                    groupedByMonth[monthName] = 0;
                }
                groupedByMonth[monthName]++;
            });

            return Object.keys(groupedByMonth).map((month) => {
                return {
                    "month": month,
                    "total": groupedByMonth[month]
                }
            });
        })
        .catch((e)=>{
            res.status(404).send({message: e.message})
        })

    res.status(200).send({picking, packing, delivery})
    // let pickingData, packingData, deliveryData, outboundData = null
    // let confDate = [
    //     {
    //         $unwind: {
    //             path: '$data'
    //         }
    //     },
    //     {
    //         $group: {
    //             _id: {
    //                 $month: { $toDate: "$data.createdAt" }
    //             },
    //             total: {
    //                 $sum: 1,
    //             }
    //         }
    //     },
    //     {
    //         $project: {
    //             month: '$_id',
    //             total: '$total',
    //             _id: false
    //         }
    //     }
    // ]
    
    // // get data picking
    // await Picking.aggregate(confDate)
    // .then((d)=>{
    //     pickingData = d
    //     console.log(pickingData)
    // })
    // .catch((e)=>{
    //     res.status(404).send({message: e.message})
    // })
    
    // // get data packing
    // await Packing.aggregate(confDate)
    // .then((d)=>{
    //     packingData = d
    //     console.log(packingData)
    // })
    // .catch((e)=>{
    //     res.status(404).send({message: e.message})
    // })

    // // get data putaways
    // await Delivery.aggregate(confDate)
    // .then((d)=>{
    //     deliveryData = d
    //     console.log(deliveryData)
    // })
    // .catch((e)=>{
    //     res.status(404).send({message: e.message})
    // })

    // outboundData = {
    //     picking: pickingData,
    //     packing: packingData,
    //     delivery: deliveryData
    // }

    // res.status(200).send(outboundData)
}

exports.dataInboundWeek = async (req, res) => {
    const receive = await Receive.find({},{createdAt: 1, _id:0})
        .then((d)=>{
            const groupedByWeek = {};

            d.forEach((item) => {
                const createdAt = new Date(item.createdAt);
                const day = new Date(item.createdAt).getDate();
                const month = createdAt.toLocaleString('default', { month: 'short' });
                const week = (Math.ceil(day / 7));
                const key = `${month}/${week}`;
            
                if (!groupedByWeek[key]) {
                    groupedByWeek[key] = 0;
                }
            
                groupedByWeek[key]++;
            });
            
            return Object.keys(groupedByWeek).map((week) => {
                return {
                    "weekOfmonth": week,
                    "total": groupedByWeek[week]
                }
            });
        })
    
    const unpacking = await Unpacking.find({},{createdAt: 1, _id:0})
        .then((d)=>{
            const groupedByWeek = {};

            d.forEach((item) => {
                const createdAt = new Date(item.createdAt);
                const day = new Date(item.createdAt).getDate();
                const month = createdAt.toLocaleString('default', { month: 'short' });
                const week = (Math.ceil(day / 7));
                const key = `${month}/${week}`;
            
                if (!groupedByWeek[key]) {
                    groupedByWeek[key] = 0;
                }
            
                groupedByWeek[key]++;
            });
            
            return Object.keys(groupedByWeek).map((week) => {
                return {
                    "weekOfmonth": week,
                    "total": groupedByWeek[week]
                }
            });
        })
    
    const putaway = await Putaway.find({},{createdAt: 1, _id:0})
        .then((d)=>{
            const groupedByWeek = {};

            d.forEach((item) => {
                const createdAt = new Date(item.createdAt);
                const day = new Date(item.createdAt).getDate();
                const month = createdAt.toLocaleString('default', { month: 'short' });
                const week = (Math.ceil(day / 7));
                const key = `${month}/${week}`;
            
                if (!groupedByWeek[key]) {
                    groupedByWeek[key] = 0;
                }
            
                groupedByWeek[key]++;
            });
            
            return Object.keys(groupedByWeek).map((week) => {
                return {
                    "weekOfmonth": week,
                    "total": groupedByWeek[week]
                }
            });
        })
    
    res.status(200).send({receive, unpacking, putaway})
    // const byWeek = [
    //     {
    //         $unwind: {path: '$data'}
    //     },
    //     {
    //         $project: {
    //             'date': '$data.createdAt',
    //             'year': {$year: {$toDate: '$data.createdAt'}},
    //             'monthInt': {$month: {$toDate: '$data.createdAt'}},
    //             'month': {
    //                 $switch: {
    //                     branches: [
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},1]},
    //                             then: 'Jan'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},2]},
    //                             then: 'Feb'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},3]},
    //                             then: 'Mar'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},4]},
    //                             then: 'Apr'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},5]},
    //                             then: 'May'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},6]},
    //                             then: 'Jun'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},7]},
    //                             then: 'Jul'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},8]},
    //                             then: 'Aug'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},9]},
    //                             then: 'Sep'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},10]},
    //                             then: 'Oct'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},11]},
    //                             then: 'Nov'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},12]},
    //                             then: 'Dec'
    //                         },
    //                     ],
    //                     default: 'notfound'
    //                 }
    //             },
    //             'week': {$add: [
    //                 {$floor: {$divide: [{$dayOfMonth: {$toDate: '$data.createdAt'}}, 7]}},
    //                 1
    //             ]}
    //         }
    //     },
    //     {
    //         $group: {
    //             _id: {month: '$month', week: '$week', monthInt: '$monthInt'},
    //             total: {$sum: 1}
    //         }
    //     },
    //     {
    //         $sort: {
    //             '_id.monthInt': 1, '_id.week': 1
    //         }
    //     },
    //     {
    //         $project: {
    //             _id: false,
    //             month: '$_id.month',
    //             week: '$_id.week',
    //             weekOfmonth: {$concat: [{$toString: '$_id.month'}, '/', {$toString: '$_id.week'}]},
    //             total: '$total'    
    //         }
    //     }
    // ]
    // const receiveData = await Receive.aggregate(byWeek)

    // const unpackingData = await Unpacking.aggregate(byWeek)

    // const putawayData = await Putaway.aggregate(byWeek)

    // // const groupByMonth = (objectArray) => {
    // //     return objectArray.reduce(function (acc, obj) {
    // //       var key = obj['month'];
    // //       if (!acc[key]) {
    // //         acc[key] = [];
    // //       }
    // //       acc[key].push(obj.total);
    // //       return acc;
    // //     }, {});
    // // }
      
    // // console.log('reduce ',groupByMonth(receiveData))
    // res.status(200).send({receiveData, unpackingData, putawayData})
}

exports.dataOutboundWeek = async (req, res) => {
    const picking = await Picking.find({},{createdAt: 1, _id:0})
        .then((d)=>{
            const groupedByWeek = {};

            d.forEach((item) => {
                const createdAt = new Date(item.createdAt);
                const day = new Date(item.createdAt).getDate();
                const month = createdAt.toLocaleString('default', { month: 'short' });
                const week = (Math.ceil(day / 7));
                const key = `${month}/${week}`;
            
                if (!groupedByWeek[key]) {
                    groupedByWeek[key] = 0;
                }
            
                groupedByWeek[key]++;
            });

            console.log(Object.keys(groupedByWeek))
            
            return Object.keys(groupedByWeek).map((week) => {
                return {
                    "weekOfmonth": week,
                    "total": groupedByWeek[week]
                }
            });
        })
    
    const packing = await Packing.find({},{createdAt: 1, _id:0})
        .then((d)=>{
            const groupedByWeek = {};

            d.forEach((item) => {
                const createdAt = new Date(item.createdAt);
                const day = new Date(item.createdAt).getDate();
                const month = createdAt.toLocaleString('default', { month: 'short' });
                const week = (Math.ceil(day / 7));
                const key = `${month}/${week}`;
            
                if (!groupedByWeek[key]) {
                    groupedByWeek[key] = 0;
                }
            
                groupedByWeek[key]++;
            });
            
            return Object.keys(groupedByWeek).map((week) => {
                return {
                    "weekOfmonth": week,
                    "total": groupedByWeek[week]
                }
            });
        })
    
    const delivery = await Delivery.find({},{createdAt: 1, _id:0})
        .then((d)=>{
            const groupedByWeek = {};

            d.forEach((item) => {
                const createdAt = new Date(item.createdAt);
                const day = new Date(item.createdAt).getDate();
                const month = createdAt.toLocaleString('default', { month: 'short' });
                const week = (Math.ceil(day / 7));
                const key = `${month}/${week}`;
            
                if (!groupedByWeek[key]) {
                    groupedByWeek[key] = 0;
                }
            
                groupedByWeek[key]++;
            });
            
            return Object.keys(groupedByWeek).map((week) => {
                return {
                    "weekOfmonth": week,
                    "total": groupedByWeek[week]
                }
            });
        })
    
    res.status(200).send({picking, packing, delivery})
    // const byWeek = [
    //     {
    //         $unwind: {path: '$data'}
    //     },
    //     {
    //         $project: {
    //             'date': '$data.createdAt',
    //             'year': {$year: {$toDate: '$data.createdAt'}},
    //             'monthInt': {$month: {$toDate: '$data.createdAt'}},
    //             'month': {
    //                 $switch: {
    //                     branches: [
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},1]},
    //                             then: 'Jan'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},2]},
    //                             then: 'Feb'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},3]},
    //                             then: 'Mar'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},4]},
    //                             then: 'Apr'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},5]},
    //                             then: 'May'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},6]},
    //                             then: 'Jun'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},7]},
    //                             then: 'Jul'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},8]},
    //                             then: 'Aug'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},9]},
    //                             then: 'Sep'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},10]},
    //                             then: 'Oct'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},11]},
    //                             then: 'Nov'
    //                         },
    //                         {
    //                             case: {$eq: [{$month: {$toDate: '$data.createdAt'}},12]},
    //                             then: 'Dec'
    //                         },
    //                     ],
    //                     default: 'notfound'
    //                 }
    //             },
    //             'week': {$add: [
    //                 {$floor: {$divide: [{$dayOfMonth: {$toDate: '$data.createdAt'}}, 7]}},
    //                 1
    //             ]}
    //         }
    //     },
    //     {
    //         $group: {
    //             _id: {month: '$month', week: '$week', monthInt: '$monthInt'},
    //             total: {$sum: 1}
    //         }
    //     },
    //     {
    //         $sort: {
    //             '_id.monthInt': 1, '_id.week': 1
    //         }
    //     },
    //     {
    //         $project: {
    //             _id: false,
    //             month: '$_id.month',
    //             week: '$_id.week',
    //             weekOfmonth: {$concat: [{$toString: '$_id.month'}, '/', {$toString: '$_id.week'}]},
    //             total: '$total'    
    //         }
    //     }
    // ]
    // const pickingData = await Picking.aggregate(byWeek)

    // const packingData = await Packing.aggregate(byWeek)

    // const deliveryData = await Delivery.aggregate(byWeek)
    // res.status(200).send({pickingData, packingData, deliveryData})
}

exports.dataOrderFulfilment = async (req, res) => {
    await Picking.find({ status: { $ne: 'Fully Picked' } },{ status: 1, _id: 0 })
    .then((d)=>{
        const result = Object.values(d.reduce((acc,{status}) => {
            let key = status;
            acc[key] = acc[key] || {title: status, total : 0};
            acc[key].total++;
            return acc;
        }, {}));
        res.status(200).send(result)
    })
    .catch((e)=>{
        res.status(404).send({message: e.message})
    })

    // await Picking.aggregate([
    //     {
    //         $unwind: {
    //             path: '$data'
    //         }
    //     },
    //     {
    //         $match: {
    //             "data.status": {
    //                 $ne: 'Fully Picked'
    //             },
    //         }
    //     },
    //     {
    //         $group: {
    //             _id: '$data.status',
    //             total: {$sum: 1}
    //         }
    //     },
    //     {
    //         $project: {
    //             _id: false,
    //             title: '$_id',
    //             total: '$total'
    //         }
    //     }
    // ])
    // .then((d)=>{
    //     res.status(200).send(d)
    // })
    // .catch((e)=>{
    //     res.status(404).send({message: e.message})
    // })
}

exports.dataOrderFillRate = async (req, res) => {
    await Picking.find({},{ status: 1, _id: 0 })
    .then((d)=>{
        const dataPicked = d.filter((el)=>{ return el.status == 'Fully Picked'})
        const ratePicked = Math.floor((dataPicked.length / d.length) * 100)
        res.send({ratePicked})
    })
    .catch((e)=>{
        res.status(404).send({message: e.message})
    })                        
    // let totalPicked, totalData = null
    // await Picking.aggregate([
    //     {
    //         $unwind: {
    //             path: '$data'
    //         },
    //     },
    //     {
    //         $match: {
    //             'data.status': 'Fully Picked'
    //         }
    //     },
    //     {
    //         $group: {
    //             _id: null,
    //             totalPicked: {$sum: 1}
    //         }
    //     }
    // ])
    // .then((d)=>{
    //     totalPicked = d[0].totalPicked
    // })
    // .catch((e)=>{res.status(404).send({message: e.message})})

    // await Picking.find()
    // .then((d)=>{
    //     totalData = d[0].data.length
    // })
    // .catch((e)=>{res.status(404).send({message: e.message})})
    
    // let ratePicked = Math.floor((totalPicked / totalData) * 100)

    // res.status(200).send({ratePicked})
}

exports.dataNotGoodRate = async (req, res) => {
    await Unpacking.find({ 'itemList.qualityControl': { $exists: true, $ne: [] } }, { 'itemList.qualityControl': 1, '_id': 0 })
    .then((d)=>{
        let allDataCondition = []
        d.map((el1)=>{
           return el1.itemList.map((el2)=>{
            return el2.qualityControl.map((el3)=>{
                return allDataCondition.push(el3.condition)
            })
           })
        })
        
        const dataNG = allDataCondition.reduce((acc, el) => {
            if (el === "NG") {
                return acc + 1;
            }
            return acc;
        }, 0);

        const rateNG = Math.floor((dataNG / allDataCondition.length) * 100)
        res.status(200).send({rateNG})
    })
    // const filter = [
    //     {
    //         $unwind: {
    //             path: '$data'
    //         }
    //     },
    //     {
    //         $match: {
    //             'data.itemList.qualityControl': {
    //                 $exists: true, $ne: []
    //             }
    //         }
    //     },
    //     {
    //         $project: {
    //             mydata: '$data.itemList.qualityControl'
    //         }
    //     },
    //     {
    //         $unwind: {
    //             path: '$mydata'
    //         }
    //     },
    //     {
    //         $unwind: {
    //             path: '$mydata'
    //         }
    //     },
    //     {
    //         $group: {
    //             _id: '$mydata.condition',
    //             total: {$sum: 1}
    //         }
    //     },
    //     {
    //         $sort: {
    //             'total': 1
    //         }
    //     },
    // ]

    // const unpackingData = await Unpacking.aggregate(filter)

    // res.status(200).send(unpackingData)
}