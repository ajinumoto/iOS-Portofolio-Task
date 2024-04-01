//
//  PortofolioEntity.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import Foundation

struct PortofolioModel: Codable {
    let type: String
    let data: PortofolioData
}

enum PortofolioData: Codable {
    case line(LineModelData)
    case pie([PieChartDatum])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([PieChartDatum].self) {
            self = .pie(x)
            return
        }
        if let x = try? container.decode(LineModelData.self) {
            self = .line(x)
            return
        }
        throw DecodingError.typeMismatch(PortofolioData.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DataUnion"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .line(let x):
            try container.encode(x)
        case .pie(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DataDatum
struct PieChartDatum: Codable {
    let label, percentage: String
    let data: [PieModelData]
}

// MARK: - DatumDatum
struct PieModelData: Codable {
    let trxDate: String
    let nominal: Int
    
    enum CodingKeys: String, CodingKey {
        case trxDate = "trx_date"
        case nominal
    }
}

// MARK: - DataClass
struct LineModelData: Codable {
    let month: [Int]
}

class PortofolioProvider {
    static let mockData = """
    [
        {
            "type": "donutChart",
            "data": [
                {
                    "label": "Tarik Tunai",
                    "percentage": "55",
                    "data": [
                        {
                            "trx_date": "21/01/2023",
                            "nominal": 1000000
                        },
                        {
                            "trx_date": "20/01/2023",
                            "nominal": 500000
                        },
                        {
                            "trx_date": "19/01/2023",
                            "nominal": 1000000
                        }
                    ]
                },
                {
                    "label": "QRIS Payment",
                    "percentage": "31",
                    "data": [
                        {
                            "trx_date": "21/01/2023",
                            "nominal": 159000
                        },
                        {
                            "trx_date": "20/01/2023",
                            "nominal": 35000
                        },
                        {
                            "trx_date": "19/01/2023",
                            "nominal": 1500
                        }
                    ]
                },
                {
                    "label": "Topup Gopay",
                    "percentage": "7.7",
                    "data": [
                        {
                            "trx_date": "21/01/2023",
                            "nominal": 200000
                        },
                        {
                            "trx_date": "20/01/2023",
                            "nominal": 195000
                        },
                        {
                            "trx_date": "19/01/2023",
                            "nominal": 5000000
                        }
                    ]
                },
                {
                    "label": "Lainnya",
                    "percentage": "6.3",
                    "data": [
                        {
                            "trx_date": "21/01/2023",
                            "nominal": 1000000
                        },
                        {
                            "trx_date": "20/01/2023",
                            "nominal": 500000
                        },
                        {
                            "trx_date": "19/01/2023",
                            "nominal": 1000000
                        }
                    ]
                }
            ]
        },
        {
            "type": "lineChart",
            "data": {
                "month": [
                    3,
                    7,
                    8,
                    10,
                    5,
                    10,
                    1,
                    3,
                    5,
                    10,
                    7,
                    7
                ]
            }
        }
    ]
    """
}
