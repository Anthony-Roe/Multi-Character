MC.MaxPlayers = 32
MC.ItemList = {
    ["marijuana"] = {
        label = "Marijuana Dime Bag",
        weight = 0.03, -- In pounds
        buyPrice = 150,
        sellPrice = 100,
        description = "A greenish-gray mixture of the dried flowers of Cannabis sativa.",
        use = {
            label = "Smoke a joint",
            description = "Smoking this joint can result in some crazy cool visions.",
        },
        give = {
            label = "[Give] a joint away",
            description = "Give this joint to the nearest person.",
        },
        drop = {
            label = "[Drop] a joint",
            description = "Drop this joint.",
        },
        sell = {
            label = "[Sell] a joint",
            description = "",
        },
        buy = {
            label = "[Buy] marijuana dime baggy",
            description = "",
        },
    },
    ["marijuanaseeds"] = {
        label = "Marijuana Seeds",
        description = "Seeds used to grow marijuana.",
        weight = 0.001, -- In pounds
        buyPrice = 50,
        sellPrice = 45,
        give = {
            label = "[Give] marijuana seeds",
            description = "Give marijuana seeds to the nearest person.",
        },
        drop = {
            label = "[Drop] marijuana seeds",
            description = "Drop marijuana seeds.",
        },
        sell = {
            label = "[Sell] marijuana seeds",
            description = "",
        },
        buy = {
            label = "[Buy]marijuana seeds",
            description = "",
        },
    },
    ["marijuanaleaf"] = {
        label = "Marijuana Leaf",
        description = "Leaf(s) that are picked from marijuana plants.",
        weight = 0.001, -- In pounds
        buyPrice = 50,
        sellPrice = 45,
        give = {
            label = "[Give] marijuana leaf(s)",
            description = "Give marijuana leaf(s) to the nearest person.",
        },
        drop = {
            label = "[Drop] marijuana leaf(s)",
            description = "Drop marijuana leaf(s).",
        },
        sell = {
            label = "[Sell] marijuana leaf(s)",
            description = "",
        },
        buy = {
            label = "[Buy] marijuana leaf(s)",
            description = "",
        },
    }
}