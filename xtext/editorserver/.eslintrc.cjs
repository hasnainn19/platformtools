module.exports = {
    "env": {
        "browser": false,
        "node": true, 
        "es2021": true
    },
    "extends": "eslint:recommended",
    "overrides": [
        {
            "env": {
                "node": true
            },
            "files": [
                ".eslintrc.{js,cjs}"
            ],
            "parserOptions": {
                "sourceType": "script"
            }
        }
    ],
    "parserOptions": {
        "ecmaVersion": 2022,
        "sourceType": "module"
    },
    "rules": {
    }
}
